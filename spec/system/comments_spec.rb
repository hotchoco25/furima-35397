require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    sleep(0.05)
    @comment = FactoryBot.build(:comment)
  end
  context "コメント投稿ができるとき" do
    it "ログインして正しい情報を入力すればコメント投稿ができる" do
      # ログインする
      sign_in(@user)
      # 商品詳細ページに移動する
      visit item_path(@item.id)
      # コメント送信ボタンがある
      expect(page).to have_content("コメントする")
      # 情報を入力する
      fill_in "comment_text", with: @comment.text
      # コメント送信ボタンを押すとcommentモデルのカウントが1上がる
      expect{
        find('button[class="comment-btn"]').click
      }.to change{ Comment.count }.by(1)
      # コメントをした商品の詳細ページに遷移する
      expect(current_path).to eq item_path(@item.id)
    end
  end
  context "コメント投稿ができないとき" do
    it "未ログインではコメント投稿ができない" do
      # 商品詳細ページに移動する
      visit item_path(@item.id)
      # コメント欄とコメント送信ボタンがない
      expect(page).to have_no_content("コメントする")
    end
    it "ログインしていても誤った情報を入力すればコメント投稿ができない" do
      # ログインする
      sign_in(@user)
      # 商品詳細ページに移動する
      visit item_path(@item.id)
      # コメント送信ボタンがある
      expect(page).to have_content("コメントする")
      # 情報を入力する
      fill_in "comment_text", with: ""
      # コメント送信ボタンを押すとcommentモデルのカウントが上がらない
      expect{
        find('button[class="comment-btn"]').click
      }.to change{ Comment.count }.by(0)
      # ページが移動しない
      expect(current_path).to eq item_path(@item.id)
    end
  end
end

RSpec.describe "コメント削除", type: :system do
  before do
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
    sleep(0.05)
  end
  context "コメント削除ができるとき" do
    it "ログインしていて自身のコメントは削除できる" do
      # ログインする
      sign_in(@comment1.user)
      # 商品詳細ページに移動する
      visit item_path(@comment1.item_id)
      # 自身のコメントに削除ボタンがある
      expect(page).to have_content("削除")
      # コメントを削除するとcommentモデルのカウントが1下がる
      expect{
        find_link("削除", href: item_comment_path(@comment1.id, @comment1.item_id)).click
      }.to change{ Comment.count }.by(-1)
      # コメントを削除した商品の詳細ページに遷移する
      expect(current_path).to eq item_path(@comment1.item_id)
      # 削除したコメントがない
      expect(page).to have_no_content(@comment1)
    end
  end
  context "コメント削除ができないとき" do
    it "未ログインでは自身のコメントでも削除できない" do
      # 商品詳細ページに移動する
      visit item_path(@comment1.item_id)
      # コメントに削除ボタンがない
      expect(page).to have_no_content("削除")
    end
    it "ログインしていても他の人のコメントは削除できない" do
      # ログインする
      sign_in(@comment1.user)
      # 商品詳細ページに移動する
      visit item_path(@comment2.item_id)
      # 別の人のコメントには削除のボタンがない
      expect(page).to have_no_content("削除")
    end
  end
end