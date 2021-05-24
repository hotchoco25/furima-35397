require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context "ユーザー新規登録ができるとき" do
    it "正しい情報を入力すればユーザー新規登録ができてトップページに移動する" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページに新規登録ボタンがある
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "nickname", with: @user.nickname
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password-confirmation", with: @user.password_confirmation
      fill_in "last-name", with: @user.last_name
      fill_in "first-name", with: @user.first_name
      fill_in "last-name-kana", with: @user.last_kana
      fill_in "first-name-kana", with: @user.first_kana
      select @user.birth.year, from: 'user[birth(1i)]'
      select @user.birth.month, from: 'user[birth(2i)]'
      select @user.birth.day, from: 'user[birth(3i)]'
      # 登録ボタンを押すとuserモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change{ User.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # ログアウトボタンがある
      expect(page).to have_content("ログアウト")
      # ニックネームがある
      expect(page).to have_content(@user.nickname)
      # 新規登録ボタンがない
      expect(page).to have_no_content("新規登録")
      # ログインボタンがない
      expect(page).to have_no_content("ログイン")
    end
  end
  context "ユーザー新規登録ができないとき" do
    it "誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページに新規登録ボタンがある
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "nickname", with: ""
      fill_in "email", with:  ""
      fill_in "password", with: ""
      fill_in "password-confirmation", with: ""
      fill_in "last-name", with: ""
      fill_in "first-name", with: ""
      fill_in "last-name-kana", with: ""
      fill_in "first-name-kana", with: ""
      # 登録ボタンを押してもuserモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ User.count }.by(0)
      # 新規登録ページに戻される
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context "ログインができるとき" do
    it "保存されているユーザー情報と合致すればログインできる" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインボタンがある
      expect(page).to have_content("ログイン")
      # ログインページに移動する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # ログアウトボタンがある
      expect(page).to have_content("ログアウト")
      # ニックネームがある
      expect(page).to have_content(@user.nickname)
      # 新規登録ボタンがない
      expect(page).to have_no_content("新規登録")
      # ログインボタンがない
      expect(page).to have_no_content("ログイン")
    end
  end
  context "ログインができないとき" do
    it "保存されているユーザー情報と合致しなければログインできない" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインボタンがある
      expect(page).to have_content("ログイン")
      # ログインページに移動する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in "email", with: ""
      fill_in "password", with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページに戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "ユーザー情報編集", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context "ユーザー情報の編集ができるとき" do
    it "マイページから編集画面に移動して正しく情報を入力すれば編集ができる" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインボタンがある
      expect(page).to have_content("ログイン")
      # ログインする
      sign_in(@user1)
      # マイページに移動する
      find_link(@user1.nickname, href: user_path(@user1.id)).click
      # 編集ボタンがある
      expect(page).to have_content("ユーザー情報の編集")
      # 編集ページに移動する
      visit edit_user_registration_path(@user1.id)
      # 登録時の情報がフォームに入っている
      expect(
        find("#nickname").value
      ).to eq(@user1.nickname)
      expect(
        find("#email").value
      ).to eq (@user1.email)
      expect(
        find("#last-name").value
      ).to eq (@user1.last_name)
      expect(
        find("#first-name").value
      ).to eq (@user1.first_name)
      expect(
        find("#last-name-kana").value
      ).to eq (@user1.last_kana)
      expect(
        find("#first-name-kana").value
      ).to eq (@user1.first_kana)
      expect(page).to have_content(@user1.birth.year)
      expect(page).to have_content(@user1.birth.month)
      expect(page).to have_content(@user1.birth.day)
      # 内容を編集する
      fill_in "nickname", with: "#{@user1.nickname}a"
      fill_in "email", with: "#{@user1.email}a"
      fill_in "last-name", with: "#{@user1.last_name}あ"
      fill_in "first-name", with: "#{@user1.first_name}あ"
      fill_in "last-name-kana", with: "#{@user1.last_kana}ア"
      fill_in "first-name-kana", with: "#{@user1.first_kana}ア"
      select "1930", from: "user[birth(1i)]"
      select "1", from: "user[birth(2i)]"
      select "1", from: "user[birth(3i)]"
      # 編集してもuserモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ User.count }.by(0)
      # マイページに遷移する
      expect(current_path).to eq user_path(@user1.id)
      # 編集した内容に変わっている
      expect(page).to have_content("#{@user1.nickname}a")
      expect(page).to have_content("#{@user1.email}a")
      expect(page).to have_content("#{@user1.last_name}あ")
      expect(page).to have_content("#{@user1.first_name}あ")
      expect(page).to have_content("#{@user1.last_kana}ア")
      expect(page).to have_content("#{@user1.first_kana}ア")
      expect(page).to have_content("1930")
      expect(page).to have_content("1")
      expect(page).to have_content("1")
    end
  end
  context "ユーザー情報の編集ができないとき" do
    it  "ログインしたユーザーは自分以外のユーザー情報を編集できない" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインボタンがある
      expect(page).to have_content("ログイン")
      # ログインする
      sign_in(@user1)
      # 別のユーザーページに移動する
      visit user_path(@user2.id)
      # 編集ボタンがない
      expect(page).to have_no_content("ユーザー情報の編集")
    end
    it "マイページから編集画面に移動して誤った情報であれば編集ができない" do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインボタンがある
      expect(page).to have_content("ログイン")
      # ログインする
      sign_in(@user1)
      # マイページに移動する
      find_link(@user1.nickname, href: user_path(@user1.id)).click
      # 編集ボタンがある
      expect(page).to have_content("ユーザー情報の編集")
      # 編集ページに移動する
      visit edit_user_registration_path(@user1.id)
      # 内容を編集する
      fill_in "nickname", with: ""
      fill_in "email", with: ""
      fill_in "last-name", with: ""
      fill_in "first-name", with: ""
      fill_in "last-name-kana", with: ""
      fill_in "first-name-kana", with: ""
      select "--", from: "user[birth(1i)]"
      select "--", from: "user[birth(2i)]"
      select "--", from: "user[birth(3i)]"
      # 編集してもuserモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change{ User.count }.by(0)
      # 編集ページに戻される
      expect(current_path).to eq user_registration_path
    end
  end
end
