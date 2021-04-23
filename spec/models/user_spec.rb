require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it 'nickname,email,password,password_confirmation,last_name,first_name,last_kana,first_kana,birthが全て存在すれば登録できる' do
      end
      it 'passwordとpassword_confirmationが６文字以上であれば登録できる' do
      end
      it 'passwordとpassword_confirmationが一致していれば登録できる' do
      end
      it 'last_nameが全角なら登録できる' do
      end
      it 'first_nameが全角なら登録できる' do
      end
      it 'last_kanaが全角カタカナなら登録できる' do
      end
      it 'first_kanaが全角カタカナなら登録できる' do
      end
    end
    context '新規登録ができないとき' do
      it 'nicknameが空では登録できない' do
      end
      it 'emailが空では登録できない' do
      end
      it '重複したemailが存在する場合登録できない' do
      end
      it 'passwordが空では登録できない' do
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
      end
      it 'passwordが５文字以下では登録できない' do
      end
      it 'last_nameが空では登録できない' do
      end
      it 'last_nameが全角でないと登録できない' do
      end
      it 'first_nameが空では登録できない' do
      end
      it 'first_nameが全角でないと登録できない' do
      end
      it 'last_kanaが空では登録できない' do
      end
      it 'last_kanaが全角カタカナでないと登録できない' do
      end
      it 'first_kanaが空では登録できない' do
      end
      it 'first_kanaが全角カタカナでないと登録できない' do
      end
      it 'birthが空では登録できない' do
      end
    end
  end
  
  describe 'ユーザーログイン' do
    context 'ログインができるとき' do
      it 'emailとpasswordが存在すればログインできる' do
      end
    end
    context 'ログインができないとき' do
      it 'emailが空ではログインできない' do
      end
      it 'passwordが空ではログインできない' do
      end
      it '登録していないemailではログインできない' do
      end
      it 'emailとpasswordの組み合わせが存在しないとログインできない' do
      end
    end
  end
end
