class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: :destroy
  before_action :redirect_path, only: :destroy

  def create
    @item = Item.find(params[:item_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      # ActionCable.server.broadcast 'comment_channel', content: @comment
      redirect_to item_path(@item.id), method: :get
    end
  end

  def destroy
    if @comment.destroy
      redirect_to item_path, method: :get
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_comment
    @item = Item.find(params[:id])
    @comment = @item.comments.find(params[:item_id])
  end

  def redirect_path
    if @comment.user_id != current_user.id
      redirect_to item_path, method: :get
    end
  end
end
