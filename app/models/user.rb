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
    validates :last_name
    validates_format_of :last_name, with: NAME_REGEX, message: NAME_REGEX_MESSAGE
    validates :first_name
    validates_format_of :first_name, with: NAME_REGEX, message: NAME_REGEX_MESSAGE
    validates :last_kana
    validates_format_of :last_kana, with: NAME_KANA_REGEX, message: NAME_KANA_REGEX_MESSAGE
    validates :first_kana
    validates_format_of :first_kana, with: NAME_KANA_REGEX, message: NAME_KANA_REGEX_MESSAGE
    validates :birth
  end
end
