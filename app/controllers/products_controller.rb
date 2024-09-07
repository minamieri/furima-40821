class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  # before_action :correct_user, only: [:edit, :update]
  before_action :set_product, only: [:edit, :update]
  before_action :check_user_permission, only: [:edit, :update]
  # before_action :check_authorization, only: [:show]

  def index
    @products = Product.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      # redirect_to product_path(@product), notice: '出品しましたぜ.'
      redirect_to root_path, notice: '出品しましたぜ.'
    else
      render :new, status: :unprocessable_entity
      # render :new
    end
  end

  def show
    @product = Product.find(params[:id])

    # if @product.status == '販売中' && @product.user_id != current_user.id
    # else
    # redirect_to products_path
    # end

    # if @product.user_id != current_user.id
    # else
    # redirect_to products_path
    # end
  end

  def edit
    @product = Product.find(params[:id])
    # @product.update(product_params)
    # redirect_to root_path
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
      # if current_product.update(product_params)
      # redirect_to root_path
    else
      render :edit, status: :unprocessable_entity # エラー記述に関わる部分
    end
  end

  # def destroy
  # @product = Product.find(params[:id])
  # @product.destroy
  # redirect_to products_url
  # end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def check_user_permission
    redirect_to root_path unless @product.user_id == current_user.id

    def product_params
      params.require(:product).permit(:image, :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id,
                                      :day_id, :price).merge(user_id: current_user.id)
    end

    def correct_user
      return if @product.user_id == current_user.id

      redirect_to root_path
      # @product = current_user.products.find_by(id: params[:id])
      # redirect_to products_path, notice: 'Not authorized to edit this product' if @product.nil?
    end

    # def check_authorization
    # return unless @product.user_id == current_user.id || @product.sold_out?

    # redirect_to products_path
    # end
  end
end
