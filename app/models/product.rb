class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  # has_one :shipping
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :area
  belongs_to_active_hash :day

  validates :image, presence: true, unless: :was_attached?
  validates :productname, :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  # validate :was_attached?
  validates :category_id, :status_id, :delivery_charge_id, :area_id, :day_id,
            numericality: { other_than: 1, message: "can't be blank" }

  def profit
    (price * 0.9).floor
  end

  private

  def was_attached?
    return if image.attached?

    errors.add(:image, 'は1枚必要です')
    # self.image.attached?
  end
end
