class CreateBuys < ActiveRecord::Migration[6.0]
  def change
    create_table :buys do |t|
      t.string :post_code, null: false
      t.integer :area_id, null: false
      t.string :muni, null: false
      t.string :add, null: false
      t.string :buil
      t.string :tel, null: false
      t.references :record, null: false, foreign_key: true
      t.timestamps
    end
  end
end
