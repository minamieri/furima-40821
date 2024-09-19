class OrderHistory < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping

  validates :user_id, presence: true
  validates :product_id, presence: true
end
