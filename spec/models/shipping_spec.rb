require 'rails_helper'

RSpec.describe Shipping, type: :model do
  before do
    @shipping = FactoryBot.build(:shipping)
  end

  context '保存できる場合' do
    it 'すべての必須項目が正しく入力されていれば保存できる' do
      @shipping.tel = '0901234567'
      expect(@shipping).to be_valid
    end
  end

  context '保存できない場合' do
    it '郵便番号が空だと保存できない' do
      @shipping.post_code = ''
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Post code can't be blank")
    end

    it '郵便番号が不正な形式だと保存できない' do
      @shipping.post_code = '1234567'
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end

    it '都道府県が選択されていないと保存できない' do
      @shipping.area_id = nil
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Area can't be blank")
    end

    it '市区町村が空だと保存できない' do
      @shipping.city = ''
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空だと保存できない' do
      @shipping.address = ''
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が空だと保存できない' do
      @shipping.tel = ''
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Tel can't be blank")
    end

    it '電話番号が10桁以上11桁以内でないと保存できない' do
      @shipping.tel = '090123456'
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include('Tel is invalid')
    end

    it '電話番号にハイフンが含まれていると保存できない' do
      @shipping.tel = '090-1234-5678'
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include('Tel is invalid')
    end
  end
end
