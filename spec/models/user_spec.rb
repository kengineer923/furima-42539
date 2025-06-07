require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネーム を入力してください')
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレス を入力してください')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレス はすでに存在します')
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testemail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレス は不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード を入力してください')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード は6文字以上で入力してください')
      end

      it 'passwordが129文字以上では登録できない' do
        long_password = 'a1' * 65
        @user.password = long_password
        @user.password_confirmation = long_password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード は128文字以内で入力してください')
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード は半角英数字を両方含む必要があります')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード は半角英数字を両方含む必要があります')
      end

      it 'passwordが全角文字を含むと登録できない' do
        @user.password = 'a1b2c３'
        @user.password_confirmation = 'a1b2c３'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード は半角英数字を両方含む必要があります')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'a1b2c3'
        @user.password_confirmation = 'a1b2c4'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード確認 が一致しません')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓 を入力してください')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名 を入力してください')
      end

      it 'last_kanaが空では登録できない' do
        @user.last_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（カタカナ） を入力してください')
      end

      it 'first_kanaが空では登録できない' do
        @user.first_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名（カタカナ） を入力してください')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日 を入力してください')
      end

      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓 は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('名 は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'last_kanaが全角カタカナでないと登録できない' do
        @user.last_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（カタカナ） は全角（カタカナ）で入力してください')
      end

      it 'first_kanaが全角カタカナでないと登録できない' do
        @user.first_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（カタカナ） は全角（カタカナ）で入力してください')
      end
    end
  end
end
