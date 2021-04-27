require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品情報の登録' do
    context '商品出品情報が登録できるとき' do
      it 'image,item_name,text,category_id,status_id,pay_id,area_id,day_id,priceが全て存在すれば登録できる' do
      end
      it 'priceが半角数字なら登録できる' do
      end
      it 'priceが300以上の数字なら登録できる' do
      end
      it 'priceが9,999,999以下の数字なら登録できる' do
      end
    end
    context '商品出品情報が登録できなとき' do
      it 'imageが空では登録できない' do
      end
      it 'item_nameが空では登録できない' do
      end
      it 'textが空では登録できない' do
      end
      it 'category_idが1では登録できない' do
      end
      it 'status_idが1では登録できない' do
      end
      it 'pay_idが1では登録できない' do
      end
      it 'area_idが1では登録できない' do
      end
      it 'day_idが1では登録できない' do
      end
      it 'priceが空では登録できない' do
      end
      it 'priceが半角数字ではないと登録できない' do
      end
      it 'priceが300未満だと登録できない' do
      end
      it 'priceが9,999,999より大きいと登録できない' do
      end
      it 'ユーザーが紐づいていないと登録できない' do
      end
    end
  end
end
