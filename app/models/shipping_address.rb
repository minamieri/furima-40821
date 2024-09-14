class ShippingAddress < ApplicationRecord
  belongs_to :order

  validates :post_code, :area_id, :city, :address, :tel, presence: true
end
