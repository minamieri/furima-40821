require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品機能' do
    context '商品出品ができる場合' do
      it '必要な情報がすべて存在すれば保存できること' do
        expect(@product).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it '商品画像が1枚必須であること' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('Image は1枚必要です')
      end

      it '商品名が必須であること' do
        @product.productname = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Productname can't be blank")
      end

      it '商品の説明が必須であること' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの入力が必須であること' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態の入力が必須であること' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担の入力が必須であること' do
        @product.delivery_charge_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery charge can't be blank")
      end

      it '発送元の地域の入力が必須であること' do
        @product.area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Area can't be blank")
      end

      it '発送までの日数の入力が必須であること' do
        @product.day_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Day can't be blank")
      end

      it '価格の入力が必須であること' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300円未満では出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999円を超えると出品できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格は半角数値のみ保存可能であること' do
        @product.price = '１０００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end

      it '販売手数料と販売利益は、小数点以下を切り捨てて表示すること' do
        @product.price = 1000
        @product.save

        expect(@product.profit).to eq((@product.price * 0.9).floor)
      end

      it 'ユーザー情報がない場合は登録できないこと' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('User must exist')
      end
    end
  end
end
