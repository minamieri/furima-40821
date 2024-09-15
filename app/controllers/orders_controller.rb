class OrdersController < ApplicationController
  def index
    @order_form = OrderForm.new
    @product = Product.find(params[:product_id]) # 購入対象の商品
  end

  def create
    @product = Product.find(params[:product_id]) # 購入対象の商品を再度取得

    @order_form = OrderForm.new(order_params)
    #  @order_form = OrderForm.new(order_params)

    if @order_form.valid?
      # pay_item
      # OrderHistory オブジェクトを作成し、保存
      order_history = OrderHistory.create(user_id: @order_form.user_id, product_id: @order_form.product_id)

      # Shipping オブジェクトを作成し、保存
      Shipping.create(post_code: @order_form.post_code, area_id: @order_form.area_id, city: @order_form.city,
                      address: @order_form.address, building_name: @order_form.building_name, tel: @order_form.tel,
                      order_history_id: order_history.id) # 正しい変数名を使用
      @order_form.save
      redirect_to root_path
    else
      puts @order_form.errors.full_messages
      # binding.pry
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:post_code, :area_id, :city, :address, :building_name, :tel, :token).merge(
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
