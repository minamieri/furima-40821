class Product < ApplicationRecord
  belongs_to :user
  has_one :shipping

  validates :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id, :days_id, :price, presence: true
end
