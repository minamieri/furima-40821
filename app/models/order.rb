class Order < ApplicationRecord
  
  # belongs_to :order_history
  belongs_to :user
  belongs_to :product
  has_one :shipping_address

  validates :user_id, presence: true
  validates :product_id, presence: true
end
