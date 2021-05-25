require 'rails_helper'

RSpec.describe "カテゴリー一覧", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "特定のカテゴリーの商品一覧にいけるとき" do
    it "特定のカテゴリーに出品商品がある" do
    end
    it "特定のカテゴリーに出品商品がない" do
    end
  end
  context "特定のカテゴリーの商品一覧にいけないとき" do
    it "未登録カテゴリーは商品一覧に行けない" do
    end
  end
end
