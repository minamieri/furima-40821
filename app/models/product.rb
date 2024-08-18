class Product < ApplicationRecord
  belongs_to :user
  has_one :shipping
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  validates :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id, :day_id, :price, presence: true

  validate :was_attached?

  private

  def was_attached?
    return if image.attached?

    errors.add(:image, 'は1枚必要です')
  end
end
