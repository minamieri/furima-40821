class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :status
  belongs_to :category
  belongs_to :delivery_charge
  belongs_to :area
  belongs_to :day

  # has_one :shipping
  has_one_attached :image

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

  def sold_out?
    status == 'sold_out'
  end

  # def on_sale?
  # self.status == "販売中"
  # end

  private

  def was_attached?
    return if image.attached?

    errors.add(:image, 'は1枚必要です')
    # self.image.attached?
  end
end
