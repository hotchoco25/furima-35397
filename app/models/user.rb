class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  #NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  #NAME_REGEX_MESSAGE = "Full-width characters"
  #NAME_KANA_REGEX = /\A[ァ-ヶ一]+\z/
  #NAME_KANA_REGEX_MASSAGE = "Full-width katakana characters"

  #validates_format_of :password, with: PASSWORD_REGEX, message: "Include both letters and numbers"
  #validates :nickname, presence: true
  #validates :last_name, presence: true
  #validates_format_of :last_name, with: NAME_REGEX, message: NAME_REGEX_MESSAGE
  #validates :first_name, presence: true
  #validates_format_of :first_name, with: NAME_REGEX, message: NAME_REGEX_MESSAGE
  #validates :last_kana, presence: true
  #validates_format_of :last_kana, with: NAME_KANA_REGEX, message: NAME_KANA_REGEX_MASSAGE
  #validates :first_kana, presence: true
  #validates_format_of :first_kana, with: NAME_KANA_REGEX, message: NAME_KANA_REGEX_MASSAGE
  #validates :birth, presence: true

end
