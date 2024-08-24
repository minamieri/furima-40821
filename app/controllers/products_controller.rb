class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # @products = Product.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # @product = current_user.products.build(product_params)
    # current_user.products: ログイン中のユーザーが作成した商品を参照。
    #  .build(product_params): 新しいProductオブジェクトを作成し、product_paramsで指定された属性（データ）をセット。
    #  ここでbuildを使うことで、新しいProductオブジェクトがメモリ上に作成されるが、この時点ではまだデータベースには保存されていない。
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
                                    :day_id, :price, :category_id).merge(user_id: current_user.id)
  end
end
