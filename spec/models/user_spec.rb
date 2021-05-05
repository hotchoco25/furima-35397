require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it 'nickname,email,password,password_confirmation,last_name,first_name,last_kana,first_kana,birthが全て存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが存在すれば登録できる' do
        @user.nickname = 'abc'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが６文字以上であれば登録できる' do
        @user.password = '1q1q1q'
        @user.password_confirmation = '1q1q1q'
        expect(@user).to be_valid
      end
      it 'last_nameが全角なら登録できる' do
        @user.last_name = 'あ'
        expect(@user).to be_valid
      end
      it 'first_nameが全角なら登録できる' do
        @user.first_name = 'あ'
        expect(@user).to be_valid
      end
      it 'last_kanaが全角カタカナなら登録できる' do
        @user.last_kana = 'ア'
        expect(@user).to be_valid
      end
      it 'first_kanaが全角カタカナなら登録できる' do
        @user.first_kana = 'ア'
        expect(@user).to be_valid
      end
      it 'birthが存在すれば登録できる' do
        @user.birth = '1 Jan 2000'
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'a.a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが５文字以下では登録できない' do
        @user.password = '5t5t5'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it 'last_kanaが空では登録できない' do
        @user.last_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana can't be blank")
      end
      it 'last_kanaが全角カタカナでないと登録できない' do
        # ひらがなの場合
        @user.last_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana Full-width katakana characters")
        # アルファベットの場合
        @user.last_kana = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana Full-width katakana characters")
      end
      it 'first_kanaが空では登録できない' do
        @user.first_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana can't be blank")
      end
      it 'first_kanaが全角カタカナでないと登録できない' do
        # ひらがなの場合
        @user.first_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana Full-width katakana characters")
        # アルファベットの場合
        @user.first_kana = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana Full-width katakana characters")
      end
      it 'birthが空では登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
