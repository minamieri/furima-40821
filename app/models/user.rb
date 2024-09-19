class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :order_histories

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  validates :password, format: { without: /\p{Han}|\p{Katakana}|\p{Hiragana}|[Ａ-Ｚａ-ｚ０-９]/, message: 'には全角文字は使えません' }

  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/

  validates :nickname, presence: true
  validates :birthday, presence: true
  validates :full_width_lastname, presence: true, format: { with: FULL_WIDTH_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :full_width_firstname, presence: true, format: { with: FULL_WIDTH_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :katakana_lastname, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid' }, presence: true
  validates :katakana_firstname, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid' }, presence: true

  private

  def password_complexity
    return unless password.present? && !password.match?(/\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/)

    errors.add :password, 'は英字と数字の両方を含めて設定してください'
  end
end
