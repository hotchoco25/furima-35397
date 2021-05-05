require 'rails_helper'

RSpec.describe RecordBuy, type: :model do

  describe '商品購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      sleep(0.05)
      @record_buy = FactoryBot.build(:record_buy, user_id: @user.id, item_id: @item.id)
    end

    context '商品購入ができるとき' do
      it '全ての項目が埋まっていれば購入できる' do
        expect(@record_buy).to be_valid
      end
      it 'buidが空でも購入できる' do
        @record_buy.buil = ""
        expect(@record_buy).to be_valid
      end
      it '電話番号が11桁以下なら購入できる' do
        @record_buy.tel = "09012345678"
        expect(@record_buy).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'クレジットカードのトークン情報が空では購入できない' do
        @record_buy.token = ""
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_codeが空では購入できない' do
        @record_buy.post_code = ""
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが-がないときは購入できない' do
        @record_buy.post_code = "1234567"
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Post code Input correctly")
      end
      it 'post_codeが半角数字ではないときは購入できない' do
        @record_buy.post_code = "１２３ー４５６７"
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Post code Input correctly")
      end
      it 'area_idが1では購入できない' do
        @record_buy.area_id = 1
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Area  Select")
      end
      it 'muniが空では購入できない' do
        @record_buy.muni = ""
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Muni can't be blank")
      end
      it 'addが空では購入できない' do
        @record_buy.add = ""
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Add can't be blank")
      end
      it 'telが空では購入できない' do
        @record_buy.tel = ""
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Tel can't be blank")
      end
      it 'telに-が含まれているときは購入できない' do
        @record_buy.tel = "0120-00-0000"
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Tel Input only number")
      end
      it 'telが全角数字では購入できない' do
        @record_buy.tel = "０９０１２３４５６７８"
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Tel Input only number")
      end
      it 'ユーザーが紐づいていないと購入できない' do
        @record_buy.user_id = nil
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("User can't be blank")
      end
      it '商品が紐づいていないと購入できない' do
        @record_buy.item_id = nil
        @record_buy.valid?
        expect(@record_buy.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
