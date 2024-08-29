class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @products = Product.all
    # @product = Product.order('created_at DESC')
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
      # render :new
    end
  end

  def edit
  end

  def update
    if current_product.update(product_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id,
                                    :day_id, :price).merge(user_id: current_user.id)
  end
end
