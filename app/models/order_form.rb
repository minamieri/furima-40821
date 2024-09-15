class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :post_code, :area_id, :city, :address, :building_name, :tel, :token

  # バリデーション
  validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含む正しい形式で入力してください' }
  validates :area_id, presence: true, numericality: { other_than: 1 }
  validates :city, presence: true
  validates :address, presence: true
  validates :tel, presence: true, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }
  # validates :token, presence: true
  validates :user_id, :product_id, presence: true
  # validates :user_id, :product_id, :post_code, :area_id, :city, :address, :tel, :token, presence: true

  def save
    return false unless valid?

    order_history = OrderHistory.create(user_id:, product_id:)
    # order_histories = OrderHistory.create(user_id:, product_id:)
    Shipping.create(post_code:, area_id:, city:, address:, building_name:, tel:,
                    order_history_id: order_history.id)

    # 住所情報を保存 ここの名前は変えなきゃ今後エラーになる
    # Shippings.create(
    # post_code:, area_id:, city:, address:,
    # building_name:, tel:, order_id: order.id
    # )
  end
end
