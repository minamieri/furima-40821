require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  context '内容に問題がない場合' do
    it 'すべての項目が正しく入力されていれば保存できる' do
      @order_form.post_code = '123-4567' # 正しい形式の郵便番号を設定
      expect(@order_form).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号が必須であること' do
      @order_form.post_code = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Post code can't be blank")
    end

    it '郵便番号は「3桁-4桁」の半角文字列でなければ保存できないこと' do
      @order_form.post_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end

    it '郵便番号は半角数値のみ保存可能であること' do
      @order_form.post_code = '１００００００'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end

    it '郵便番号は「3桁-4桁」の形式であれば保存できること' do
      @order_form.post_code = '123-4567'
      expect(@order_form).to be_valid
    end

    it '都道府県が必須であること' do
      @order_form.area_id = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Area can't be blank")
    end

    it '市区町村が必須であること' do
      @order_form.city = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end

    it '番地が必須であること' do
      @order_form.address = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Address can't be blank")
    end

    it '建物名は任意であること' do
      @order_form.building_name = ''
      @order_form.post_code = '123-4567'
      expect(@order_form).to be_valid
    end

    it '電話番号が必須であること' do
      @order_form.tel = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Tel can't be blank")
    end

    it '電話番号は10桁以上11桁以内の半角数値でなければ保存できないこと（例: 090-1234-5678）' do
      @order_form.tel = '090-1234-5678'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Tel is invalid. Input only number')
    end

    it '電話番号は半角数値のみ保存可能であること' do
      @order_form.tel = '０９０１２３４５６７８'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Tel is invalid. Input only number')
    end

    it '電話番号が10桁以上11桁以内であれば保存できること' do
      @order_form.post_code = '123-4567' # 有効な郵便番号を設定
      @order_form.tel = '09012345678'
      expect(@order_form).to be_valid
    end
  end
end
