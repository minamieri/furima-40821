class Shipping < ApplicationRecord
  belongs_to :order_history

  validates :post_code, :area_id, :city, :address, :tel, presence: true
end
