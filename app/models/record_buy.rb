class RecordBuy
  include ActiveModel::Model
  attr_accessor :post_code, :area_id, :muni, :add, :buil, :tel, :user_id, :item_id

  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly'}
  with_options presence: true do
    validates :user_id
    validates :item_id

    validates :area_id, numericality: { other_than: 1, message: " Select" }
    validates :muni
    validates :add
    validates :tel, format: {with: /\A[0-9]\z/, message: 'Input only number'}
  end

  def save
    record = Record.create(user_id: user_id, item_id: item_id)

    Buy.save(post_code: post_code, area_id: area_id, muni: muni, add: add, buil: buil, tel: tel, record_id: record.id)
  end
end