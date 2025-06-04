require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
      it '価格が300円ちょうどでも出品できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '価格が9,999,999円でも出品できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像 を入力してください")
      end
      it '商品名が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名 を入力してください")
      end
      it '商品の説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明 を入力してください")
      end
      it 'カテゴリーが---（id:1）では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリー は1以外の値にしてください")
      end
      it '商品の状態が---（id:1）では出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態 は1以外の値にしてください")
      end
      it '配送料の負担が---（id:1）では出品できない' do
        @item.shipping_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担 は1以外の値にしてください")
      end
      it '発送元の地域が---（id:1）では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域 は1以外の値にしてください")
      end
      it '発送までの日数が---（id:1）では出品できない' do
        @item.duration_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数 は1以外の値にしてください")
      end
      it '価格が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 を入力してください")
      end
      it '価格が300円未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300以上の値にしてください")
      end
      it '価格が9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は9999999以下の値にしてください")
      end
      it '価格が半角数字以外では出品できない（全角数字）' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は数値で入力してください")
      end
      it '価格が半角英字では出品できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は数値で入力してください")
      end
      it '価格が半角英数混合では出品できない' do
        @item.price = '300yen'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は数値で入力してください")
      end
      it 'ユーザーが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User を入力してください")
      end
    end
  end
end
