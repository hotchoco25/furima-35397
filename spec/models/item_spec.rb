require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品情報の登録' do
    context '商品出品情報が登録できるとき' do
      it 'image,item_name,text,category_id,status_id,pay_id,area_id,day_id,priceが全て存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'priceが半角数字なら登録できる' do
        @item.price = 12345
        expect(@item).to be_valid
      end
      it 'priceが300以上の数字なら登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9,999,999以下の数字なら登録できる' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    
    context '商品出品情報が登録できなとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'textが空では登録できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選んでください")
      end
      it 'status_idが1では登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status を選んでください")
      end
      it 'pay_idが1では登録できない' do
        @item.pay_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Pay を選んでください")
      end
      it 'area_idが1では登録できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Area を選んでください")
      end
      it 'day_idが1では登録できない' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day を選んでください")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角数字ではないと登録できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price を半角数字で入力してください")
      end
      it 'priceが300未満だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price を¥300〜9,999,999で入力してください")
      end
      it 'priceが9,999,999より大きいと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price を¥300〜9,999,999で入力してください")
      end
      it 'ユーザーが紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
