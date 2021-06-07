require 'rails_helper'

RSpec.describe "商品購入", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    sleep(0.05)
    @record_buy = FactoryBot.build(:record_buy, user_id: @item1.user.id, item_id: @item2.id)
    @card_number = 4242424242424242
    @card_exp_month = 1
    @card_exp_year = 23
    @card_cvc = 123
  end
  context "商品購入ができるとき" do
    it "ログインしていて正しい情報を入力すれば商品購入ができる" do
      # ログインする
      sign_in(@item1.user)
      # 商品詳細ページに移動する
      visit item_path(@item2.id)
      # 商品購入ボタンがある
      expect(page).to have_content("購入画面に進む")
      # 商品購入ページに移動する
      visit item_records_path(@item2.id)
      # 情報を入力する
      fill_in "card-number", with: @card_number
      fill_in "card-exp-month", with: @card_exp_month
      fill_in "card-exp-year", with: @card_exp_year
      fill_in "card-cvc", with: @card_cvc
      fill_in "postal-code", with: @record_buy.post_code
      select "東京都", from: "record_buy[area_id]"
      fill_in "city", with: @record_buy.muni
      fill_in "addresses", with: @record_buy.add
      fill_in "phone-number", with: @record_buy.tel
      # 購入ボタンがある
      expect(page).to have_content("購入")
    end
  end
  context "商品購入ができないとき" do
    it "未ログインでは商品購入はできない" do
      # 商品詳細ページに移動する
      visit item_path(@item1.id)
      # 編集ボタンがない
      expect(page).to have_no_content("商品の編集")
      # 商品購入ボタンがない
      expect(page).to have_no_content("購入画面に進む")
    end
    it "ログインしていても誤った情報を入力すれば商品購入はできない" do
      # ログインする
      sign_in(@item1.user)
      # 商品詳細ページに移動する
      visit item_path(@item2.id)
      # 商品購入ボタンがある
      expect(page).to have_content("購入画面に進む")
      # 商品購入ページに移動する
      visit item_records_path(@item2.id)
      # 情報を入力する
      fill_in "card-number", with: ""
      fill_in "card-exp-month", with: ""
      fill_in "card-exp-year", with: ""
      fill_in "card-cvc", with: ""
      fill_in "postal-code", with: ""
      select "---", from: "record_buy[area_id]"
      fill_in "city", with: ""
      fill_in "addresses", with: ""
      fill_in "phone-number", with: ""
      # 購入ボタンを押してもrecordモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ Record.count }.by(0)
      # 商品購入ページに戻される
      expect(current_path).to eq item_records_path(@item2.id)
    end
    it "ログインしていても自身の出品商品は購入できない" do
      # ログインする
      sign_in(@item1.user)
      # 自身が出品している商品詳細ページに移動する
      visit item_path(@item1.id)
      # 編集ボタンがある
      expect(page).to have_content("商品の編集")
      # 購入ボタンがない
      expect(page).to have_no_content("購入画面に進む")
    end
  end
end
