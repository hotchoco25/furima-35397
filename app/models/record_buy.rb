class RecordBuy
  include ActiveModel::Model
  attr_accessor :post_code, :area_id, :muni, :add, :buil, :tel, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'を - ありの半角数字で入力してください' }
    validates :area_id, numericality: { other_than: 1, message: "を選んでください" }
    validates :user_id
    validates :item_id
    validates :muni
    validates :add
    validates :tel, format: { with: /\A[0-9]+\z/, message: 'を半角数字で入力してください' }
  end

  def save
    record = Record.create(user_id: user_id, item_id: item_id)

    Buy.create(post_code: post_code, area_id: area_id, muni: muni, add: add, buil: buil, tel: tel, record_id: record.id)
  end
end
