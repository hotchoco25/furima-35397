class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :record
  has_many :comments, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :pay
  belongs_to :area
  belongs_to :day

  with_options presence: true do
    validates :image
    validates :item_name
    validates :text
    with_options numericality: { other_than: 1, message: "を選んでください" } do
      validates :category_id
      validates :status_id
      validates :pay_id
      validates :area_id
      validates :day_id
    end
    validates :price, numericality: { only_integer: true, message: "を半角数字で入力してください" },
                      inclusion: { in: 300..9999999, message: "を¥300〜9,999,999で入力してください" }
  end
end
