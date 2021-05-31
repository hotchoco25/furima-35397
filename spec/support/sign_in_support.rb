module SignInSupport
  def sign_in(user)
    # ログインページに移動する
    basic_pass root_path
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページに遷移する
    expect(current_path).to eq(root_path)
    # ニックネームがある
    expect(page).to have_content(user.nickname)
  end
end