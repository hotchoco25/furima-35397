class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :record
  has_many :comments

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
    with_options numericality: { other_than: 1, message: " Select" } do
      validates :category_id
      validates :status_id
      validates :pay_id
      validates :area_id
      validates :day_id
    end
    validates :price, numericality: { only_integer: true, message: "Half-width number" },
                      inclusion: { in: 300..9999999, message: "Out of setting range" }
  end
end
