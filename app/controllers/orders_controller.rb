class OrdersController < ApplicationController
  # before_action :set_product, only: [:new, :create]
  def index
    # @order_form = OrderForm.new(order_form_params)　 order_form_params はここで呼び出されていないはず
    @order_form = OrderForm.new
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    @order_form = OrderForm.new(order_form_params)

    if @order_form.valid?
      # pay_item
      @order_form.save
      redirect_to root_path
    else
      binding.pry
      @product = Product.find(params[:product_id])
      # @order_form.errors.full_messages
      # puts @order_form.errors.full_messages
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_form_params
    # def order_params
    params.require(:order_form).permit(:post_code, :area_id, :city, :address, :building_name, :tel).merge(
      user_id: current_user.id, product_id: params[:product_id]
    )
  end

  # def pay_item
  # Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  # charge = Payjp::Charge.create(
  # amount: @product.price,
  # card: order_params[:token],
  # currency: 'jpy'
  # )
  # puts charge
  # end
end
