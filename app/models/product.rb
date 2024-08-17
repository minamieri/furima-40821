class Product < ApplicationRecord
  belongs_to :user
  has_one :shipping
  has_one_attached :image

  validates :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id, :days_id, :price, presence: true
end
