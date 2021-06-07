require 'rails_helper'

RSpec.describe "カテゴリー一覧", type: :system do
  before do
    @item = FactoryBot.create(:item)
    sleep(0.05)
  end
  context "特定のカテゴリーの商品一覧にいけるとき" do
    it "特定のカテゴリーに出品商品がある" do
      # トップページにいる
      basic_pass root_path
      visit root_path
      # カテゴリー一覧がある
      expect(page).to have_content("カテゴリー")
      find('.category-list').click
      expect(page).to have_content("レディース")
      expect(page).to have_content("メンズ")
      expect(page).to have_content("ベビー・キッズ")
      expect(page).to have_content("インテリア・住まい・小物")
      expect(page).to have_content("本・音楽・ゲーム")
      expect(page).to have_content("おもちゃ・ホビー・グッズ")
      expect(page).to have_content("家電・スマホ・カメラ")
      expect(page).to have_content("スポーツ・レジャー")
      expect(page).to have_content("ハンドメイド")
      expect(page).to have_content("その他")
      # 出品があるカテゴリーに移動する
      visit category_path(@item.category_id)
      # 商品情報がある
      expect(page).to have_content(@item.item_name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.pay.pay_name)
    end
    it "特定のカテゴリーに出品商品がない" do
      # トップページにいる
      basic_pass root_path
      visit root_path
      # 出品がないカテゴリーに移動する
      if @item.category_id == 2
        visit category_path(3)
      else
        visit category_path(2)
      end
      # ダミー情報がある
      expect(page).to have_content("商品を出品してね！")
      expect(page).to have_content("99999999円")
      expect(page).to have_content("(税込み)")
    end
  end
  context "特定のカテゴリーの商品一覧にいけないとき" do
    it "未登録カテゴリーは商品一覧に行けない" do
      # トップページにいる
      basic_pass root_path
      visit root_path
      # 見登録のカテゴリーに移動する
      visit category_path(1)
      # トップページに戻される
      expect(current_path).to eq root_path
    end
  end
end
