# spec/models/order_address_spec.rb
require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    let(:user) { FactoryBot.create(:user) }
    let(:item) { FactoryBot.create(:item, user: FactoryBot.create(:user)) }
    # テスト用のトークンを追加
    let(:order_address) do
      FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, token: 'tok_abcdefghijk00000000000000000')
    end
    before do
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(order_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        order_address.building = ''
        expect(order_address).to be_valid
      end

      it 'saveメソッドでOrderとAddressが作成されること' do
        expect { order_address.save }.to change(Order, :count).by(1).and change(Address, :count).by(1)
      end

      it 'saveメソッドがtrueを返すこと' do
        expect(order_address.save).to be true
      end

      it '作成されたAddressが正しいOrderに紐づいていること' do
        order_address.save
        expect(Address.last.order_id).to eq Order.last.id
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        order_address.token = nil
        order_address.valid?
        expect(order_address.errors.full_messages).to include('クレジットカード情報 を入力してください')
      end

      it 'user_idが空では登録できないこと' do
        order_address.user_id = nil
        order_address.valid?
        expect(order_address.errors.full_messages).to include('ユーザー を入力してください')
      end

      it 'item_idが空では登録できないこと' do
        order_address.item_id = nil
        order_address.valid?
        expect(order_address.errors.full_messages).to include('商品 を入力してください')
      end

      it 'postal_codeが空だと保存できないこと' do
        order_address.postal_code = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include('郵便番号 を入力してください')
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと (ハイフンなし)' do
        order_address.postal_code = '1234567' # ハイフンなし
        order_address.valid?
        expect(order_address.errors.full_messages).to include('郵便番号 is invalid. Include hyphen(-)')
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと (全角)' do
        order_address.postal_code = '１２３－４５６７' # 全角ハイフンと数字
        order_address.valid?
        expect(order_address.errors.full_messages).to include('郵便番号 is invalid. Include hyphen(-)')
      end

      it 'prefecture_idが1では保存できない' do
        order_address.prefecture_id = 1
        order_address.valid?
        expect(order_address.errors.full_messages).to include("都道府県 can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        order_address.city = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include('市区町村 を入力してください')
      end

      it 'addressが空だと保存できないこと' do
        order_address.address = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include('番地 を入力してください')
      end

      it 'phone_numberが空だと保存できないこと' do
        order_address.phone_number = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include('電話番号 を入力してください')
      end
      it 'phone_numberが9桁だと保存できないこと' do
        order_address.phone_number = '090123456'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('電話番号 is invalid.')
      end
      it 'phone_numberが12桁だと保存できないこと' do
        order_address.phone_number = '090123456789'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('電話番号 is invalid.')
      end
      it 'phone_numberにハイフンが含まれていると保存できないこと' do
        order_address.phone_number = '090-1234-5678'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('電話番号 is invalid.')
      end
      it 'phone_numberが全角数字だと保存できないこと' do
        order_address.phone_number = '０９０１２３４５６７８'
        order_address.valid?
        expect(order_address.errors.full_messages).to include('電話番号 is invalid.')
      end

      context 'saveメソッド呼び出し時' do
        before do
          order_address.token = nil # 無効な状態にする
        end

        it 'saveメソッドがfalseを返すこと' do
          expect(order_address.save).to be false
        end

        it 'Orderレコードが作成されないこと' do
          expect { order_address.save }.not_to change(Order, :count)
        end

        it 'Addressレコードが作成されないこと' do
          expect { order_address.save }.not_to change(Address, :count)
        end
      end
    end
  end
end
