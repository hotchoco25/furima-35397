class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def update_without_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  PASSWORD_REGEX_MESSAGE = "を半角英数字で入力してください"
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_REGEX_MESSAGE = "を全角で入力してください"
  NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  NAME_KANA_REGEX_MESSAGE = "を全角カタカナで入力してください"

  with_options presence: true do
    validates :nickname
    validates :password, format: { with: PASSWORD_REGEX, message: PASSWORD_REGEX_MESSAGE }, on: :create
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
  has_many :records
  has_many :comments
end
