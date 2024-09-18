class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out_or_not_seller, only: [:edit, :update]

  def index
    @products = Product.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: '出品しましたぜ.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def redirect_if_sold_out_or_not_seller
    return unless @product.sold_out? || @product.user_id != current_user.id

    redirect_to root_path
  end

  def check_user_permission
    redirect_to root_path unless @product.user_id == current_user.id
  end

  def product_params
    if current_user
      params.require(:product).permit(:image, :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id,
                                      :day_id, :price).merge(user_id: current_user.id)
    else
      redirect_to new_user_session_path
    end
  end
end
