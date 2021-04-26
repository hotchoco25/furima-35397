class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :pay
  belongs_to :area
  belongs_to :day

  with_options presence: true do
    validates :item_name
    validates :text
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :pay_id
      validates :area_id
      validates :day_id
    end
    validates :price
  end
end
