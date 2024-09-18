class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :post_code, :area_id, :city, :address, :building_name, :tel, :token

  validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :area_id, presence: true, numericality: { other_than: 1 }
  validates :city, presence: true
  validates :address, presence: true
  validates :tel, presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
  validates :token, presence: { message: 'can\'t be blank' }
  validates :user_id, :product_id, presence: true

  def save
    return false unless valid?

    order_history = OrderHistory.create(user_id:, product_id:)
    Shipping.create(post_code:, area_id:, city:, address:, building_name:, tel:,
                    order_history_id: order_history.id)
  end
end
