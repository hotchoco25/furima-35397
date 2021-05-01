class Buy < ApplicationRecord
  belongs_to :record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
end
