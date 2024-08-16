class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to '/'
  end

  private

  def product_params
    params.require(:product).permit(:productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id,
                                    :days_id, :price, :user_id)
  end
end
