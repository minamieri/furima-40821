require 'rails_helper'

RSpec.describe OrderHistory, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
    @order_history = FactoryBot.build(:order_history, user: @user, product: @product)
  end

  context '保存できる場合' do
    it 'user_idとproduct_idが存在すれば保存できる' do
      expect(@order_history).to be_valid
    end
  end

  context '保存できない場合' do
    it 'user_idが存在しない場合保存できない' do
      @order_history.user = nil
      @order_history.valid?
      expect(@order_history.errors.full_messages).to include('User must exist')
    end

    it 'product_idが存在しない場合保存できない' do
      @order_history.product = nil
      @order_history.valid?
      expect(@order_history.errors.full_messages).to include('Product must exist')
    end
  end
end
