class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = Item.order("created_at DESC").includes(:user)
  end
end
