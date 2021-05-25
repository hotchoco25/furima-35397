require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "コメント投稿ができるとき" do
    it "ログインして正しい情報を入力すればコメント投稿ができる" do
    end
  end
  context "コメント投稿ができないとき" do
    it "未ログインではコメント投稿ができない" do
    end
    it "ログインしていても誤った情報を入力すればコメント投稿ができない" do
    end
  end
end

RSpec.describe "コメント削除", type: :system do
  before do
    driven_by(:rack_test)
  end
  context "コメント削除ができるとき" do
    it "ログインしていて自身のコメントは削除できる" do
    end
  end
  context "コメント削除ができないとき" do
    it "未ログインでは自身のコメントでも削除できない" do
    end
    it "ログインしていても他の人のコメントは削除できない" do
    end
  end
end