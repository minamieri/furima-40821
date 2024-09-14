class OrdersController < ApplicationController
  def index
    @order_form = OrderForm.new
    @product = Product.find(params[:product_id]) # 購入対象の商品
  end

  def create
     @product = Product.find(params[:product_id]) # 購入対象の商品を再度取得

     @order_form = OrderForm.new(order_params)
     binding.pry
    #  @order_form = OrderForm.new(order_params)

     if @order_form.valid?
       pay_item
       @order_form.save
       redirect_to root_path
     else
      puts @order_form.errors.full_messages
      render :index
      # render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:user_id, :product_id, :post_code, :area_id, :city, :address, :building_name,
                                       :tel, :token)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    charge = Payjp::Charge.create(
      amount: @product.price,
      card: order_params[:token],
      currency: 'jpy'
     )
     puts charge
  end
end
