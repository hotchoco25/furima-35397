require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの投稿' do
    context 'コメントが投稿できるとき' do
      it 'textがあれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが投稿できないとき' do
      it 'textが空では投稿できない' do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end
