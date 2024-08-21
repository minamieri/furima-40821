class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :shipping
  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :area
  belongs_to :day

  validates :image, presence: true, unless: :was_attached?
  validates :productname, :description, :category_id, :status_id, :delivery_charge_id, :area_id, :day_id, :price, presence: true
  validate :was_attached?
  # 空の投稿を保存できないようにする
  validates :description, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :status_id, :delivery_charge_id, :area_id, :day_id,
            numericality: { other_than: 1, message: "can't be blank" }

  private

  def was_attached?
    return if image.attached?

    errors.add(:image, 'は1枚必要です')
  end
end
