class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

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
      # render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if current_product.update(product_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:image, :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id,
                                    :day_id, :price).merge(user_id: current_user.id)
  end

  def correct_user
    @product = current_user.products.find_by(id: params[:id])
    redirect_to products_path, notice: 'Not authorized to edit this product' if @product.nil?
  end
end
