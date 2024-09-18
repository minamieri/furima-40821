class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]
  before_action :move_to_root_path, only: [:index]
  def index
    @order_form = OrderForm.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def redirect_if_seller
    return unless @product.user_id == current_user.id

    redirect_to root_path
  end

  def order_form_params
    params.require(:order_form).permit(:post_code, :area_id, :city, :address, :building_name, :tel).merge(
      user_id: current_user.id, product_id: params[:product_id], token: params[:token]
    )
  end

  def move_to_root_path
    return unless @product.order_history.present? || @product.user_id == current_user.id

    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    charge = Payjp::Charge.create(
      amount: @product.price,
      card: order_form_params[:token],
      currency: 'jpy'
    )
  end
end
