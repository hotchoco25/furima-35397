require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "商品の新規登録ができるとき" do
    it "ログインしていて商品情報を正しく入力すれば商品が登録できる" do
    end
  end
  context "商品の新規登録ができないとき" do
    it "未ログインでは商品出品ができない" do
    end
    it "ログインしていて商品情報を誤って入力すれば商品が登録できない" do
    end
  end
end

RSpec.describe "商品編集", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "商品情報の編集ができるとき" do
    it "ログインしていて自身の出品商品の情報を更新できる" do
    end
  end
  context "商品情報の編集ができないとき" do
    it "未ログインでは商品編集ができない" do
    end
    it "ログインしていても他の人が出品した商品の情報は編集できない" do
    end
    it "ログインしていて商品情報を誤っって入力すれば更新できない" do
    end
  end
end

RSpec.describe "商品削除", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "出品商品の削除ができるとき" do
    it "ログインしていて自身の出品商品を削除できる" do
    end
  end
  context "出品商品の削除ができないとき" do
    it "未ログインでは商品削除ができない" do
    end
    it "ログインしていても他の人の出品した商品は削除できない" do
    end
  end
end
