class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiverecordExtensions
  belongs_to [:category, :status, :pay, :area, :day]
end
