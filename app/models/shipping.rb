class Shipping < ApplicationRecord
  belongs_to :order_history

  validates :area_id, :city, :address, presence: true
  validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :tel, presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
end
