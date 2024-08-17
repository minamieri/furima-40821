class Product < ApplicationRecord
  belongs_to :user
  has_one :shipping

  validates :productname, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :area_id, presence: true
  validates :days_id, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
end
