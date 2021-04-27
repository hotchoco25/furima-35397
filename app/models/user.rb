class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  PASSWORD_REGEX_MESSAGE = "Include both letters and numbers"
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_REGEX_MESSAGE = "Full-width characters"
  NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  NAME_KANA_REGEX_MESSAGE = "Full-width katakana characters"

  with_options presence: true do
    validates :nickname
    validates_format_of :password, with: PASSWORD_REGEX, message: PASSWORD_REGEX_MESSAGE
    with_options format: { with: NAME_REGEX, message: NAME_REGEX_MESSAGE } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: NAME_KANA_REGEX, message: NAME_KANA_REGEX_MESSAGE } do
      validates :last_kana
      validates :first_kana
    end
    validates :birth
  end

  has_many :items
end
