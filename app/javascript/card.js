const pay = () => {
    const publicKey = gon.public_key;
    if (!publicKey) {
      console.error("PAYJP public key is not set.");
      return;
    }
    const payjp = Payjp(publicKey);
    const elements = payjp.elements();

    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    const form = document.getElementById('charge-form');
    if (!form) {
      console.error("Charge form not found.");
      return;
    }

    form.addEventListener("submit", (e) => {
        e.preventDefault(); // フォームのデフォルト送信を最初に止める

        payjp.createToken(numberElement).then(function (response) {
            console.log("PAYJP Response:", response);
            if (response.error) {
                console.error("PAYJP Error:", response.error);
                // トークン取得失敗。この場合、隠し<input name='token'>は追加されない。
                // クライアントサイドでエラーを表示したい場合はここに記述することも可能です。
                // 例: alert('カード情報が無効です: ' + response.error.message);
            } else {
                // トークン取得成功
                const token = response.id;
                const renderDom = document.getElementById("charge-form");
                // 既存のトークンがあれば削除（重複追加を防ぐため）
                const existingTokenField = renderDom.querySelector("input[name='token']");
                if (existingTokenField) {
                    existingTokenField.remove();
                }
                const tokenObj = `<input value=${token} name='token' type="hidden">`;
                renderDom.insertAdjacentHTML("beforeend", tokenObj);

                // カード情報入力フォームをクリア
                numberElement.clear();
                expiryElement.clear();
                cvcElement.clear();
            }
        }).catch(function(error) {
            console.error("Error in createToken promise:", error);
            // PAYJP SDKのPromiseで予期せぬエラーが発生した場合の処理
            // alert("決済処理中に予期せぬエラーが発生しました。");
        }).finally(function() {
            // トークン取得処理が成功しても失敗しても、最終的にフォームを送信する
            // これにより、トークンが空でもサーバーサイドのバリデーションが実行される
            document.getElementById("charge-form").submit();
        });
    });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);