require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end
  context "商品の新規登録ができるとき" do
    it "ログインしていて商品情報を正しく入力すれば商品が登録できる" do
      # ログインする
      sign_in(@user)
      # 出品ボタンがある
      expect(page).to have_content("出品する")
      # 新規出品ページに移動する
      visit new_item_path
      # 商品情報を入力する
      attach_file "item-image", "public/images/test_image.png"
      fill_in "item-name", with: @item.item_name
      fill_in "item-info", with: @item.text
      select @item.category.category_name, from: "item[category_id]"
      select @item.status.status_name, from: "item[status_id]"
      select @item.pay.pay_name, from: "item[pay_id]"
      select @item.area.area_name, from: "item[area_id]"
      select @item.day.day_name, from: "item[day_id]"
      fill_in "item-price", with: @item.price
      # 登録ボタンを押すとitemモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change{ Item.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # 出品した商品の情報がある
      expect(page).to have_content(@item.item_name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.pay.pay_name)
    end
  end
  context "商品の新規登録ができないとき" do
    it "未ログインでは商品出品ができない" do
      # 出品ボタンがある
      basic_pass root_path
      expect(page).to have_content("出品する")
      # 新規出品ページに移動するとログインページに遷移する
      visit new_item_path
      expect(current_path).to eq new_user_session_path
    end
    it "ログインしていて商品情報を誤って入力すれば商品が登録できない" do
      # ログインする
      sign_in(@user)
      # 出品ボタンがある
      expect(page).to have_content("出品する")
      # 新規出品ページに移動する
      visit new_item_path
      # 商品情報を入力する
      fill_in "item-name", with: ""
      fill_in "item-info", with: ""
      fill_in "item-price", with: ""
      # 登録ボタンを押してもitemモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ Item.count }.by(0)
      # 出品ページに戻される
      expect(current_path).to eq items_path
    end
  end
end

RSpec.describe "商品編集", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    sleep(0.05)
  end
  context "商品情報の編集ができるとき" do
    it "ログインしていて自身の出品商品の情報を更新できる" do
      # ログインする
      sign_in(@item1.user)
      # 商品詳細ページに移動する
      visit item_path(@item1.id)
      # 商品編集ボタンがある
      expect(page).to have_content("商品の編集")
      # 商品編集ページに移動する
      visit edit_item_path(@item1.id)
      # 登録時の情報がフォームに入っている
      expect(
        find("#item-name").value
      ).to eq (@item1.item_name)
      expect(
        find("#item-info").value
      ).to eq (@item1.text)
      expect(page).to have_content(@item1.category.category_name)
      expect(page).to have_content(@item1.status.status_name)
      expect(page).to have_content(@item1.pay.pay_name)
      expect(page).to have_content(@item1.area.area_name)
      expect(page).to have_content(@item1.day.day_name)
      expect(
        find("#item-price").value
      ).to eq ("#{@item1.price}")
      # 内容を編集する
      fill_in "item-name", with: "a"
      fill_in "item-info", with: "a"
      select "レディース", from: "item[category_id]"
      select "新品、未使用", from: "item[status_id]"
      select "着払い(購入者負担)", from: "item[pay_id]"
      select "北海道", from: "item[area_id]"
      select "1~2日で発送", from: "item[day_id]"
      fill_in "item-price", with: "300"
      # 更新ボタンを押してもitemモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ Item.count }.by(0)
      # 商品詳細ページに遷移する
      visit edit_item_path(@item1.id)
    end
  end
  context "商品情報の編集ができないとき" do
    it "未ログインでは商品編集ができない" do
      # 商品詳細へーじに移動する
      basic_pass root_path
      visit edit_item_path(@item1.id)
      # 商品編集ボタンがない
      expect(page).to have_no_content("商品の編集")
    end
    it "ログインしていても他の人が出品した商品の情報は編集できない" do
      # ログインする
      sign_in(@item1.user)
      # 別の人が出品した商品詳細ページに移動する
      visit edit_item_path(@item2.id)
      # 商品編集ボタンがない
      expect(page).to have_no_content("商品の編集")
    end
    it "ログインしていて商品情報を誤っって入力すれば更新できない" do
      # ログインする
      sign_in(@item1.user)
      # 商品詳細ページに移動する
      visit item_path(@item1.id)
      # 商品編集ボタンがある
      expect(page).to have_content("商品の編集")
      # 商品編集ページに移動する
      visit edit_item_path(@item1.id)
      # 内容を編集する
      fill_in "item-name", with: ""
      fill_in "item-info", with: ""
      select "---", from: "item[category_id]"
      select "---", from: "item[status_id]"
      select "---", from: "item[pay_id]"
      select "---", from: "item[area_id]"
      select "---", from: "item[day_id]"
      fill_in "item-price", with: ""
      # 更新ボタンを押してもitemモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ Item.count }.by(0)
      # 編集ページに戻される
      expect(current_path).to eq item_path(@item1.id)
    end
  end
end

RSpec.describe "商品削除", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    sleep(0.05)
  end
  context "出品商品の削除ができるとき" do
    it "ログインしていて自身の出品商品を削除できる" do
      # ログインする
      sign_in(@item1.user)
      # 商品詳細ページに移動する
      visit item_path(@item1.id)
      # 削除ボタンがある
      expect(page).to have_content("削除")
      # 削除ボタンを押すとitemモデルのカウントが1下がる
      expect{
        find_link("削除", href: item_path(@item1.id)).click
      }.to change{ Item.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # 削除した商品の情報がない
      expect(page).to have_no_content(@item1.item_name)
      expect(page).to have_no_content(@item1.price)
      expect(page).to have_no_content(@item1.pay.pay_name)
    end
  end
  context "出品商品の削除ができないとき" do
    it "未ログインでは商品削除ができない" do
      # 商品詳細ページに移動する
      visit item_path(@item1.id)
      # 削除ボタンがない
      expect(page).to have_no_content("削除")
    end
    it "ログインしていても他の人の出品した商品は削除できない" do
      # ログインする
      sign_in(@item1.user)
      # 商品詳細ページに移動する
      visit item_path(@item2.id)
      # 削除ボタンがない
      expect(page).to have_no_content("削除")
    end
  end
end
