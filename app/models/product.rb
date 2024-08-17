class Product < ApplicationRecord
  belongs_to :user
  has_one :shipping

  validates :productname, :escription, :category_id, :status_id, :delivery_charge_id, :area_id, :day_id, :price, ;presence: true
end
