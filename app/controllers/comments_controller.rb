class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @comment = Comments.create(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: current_item.id)
  end
end
