require 'rails_helper'

RSpec.describe "商品購入", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "商品購入ができるとき" do
    it "ログインしていて正しい情報を入力すれば商品購入ができる" do
    end
  end
  context "商品購入ができないとき" do
    it "未ログインでは商品購入はできない" do
    end
    it "ログインしていても誤った情報を入力すれば商品購入はできない" do
    end
    it "ログインしていても自身の出品商品は購入できない" do
    end
  end
end
