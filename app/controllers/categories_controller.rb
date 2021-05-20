class CategoriesController < ApplicationController
  before_action :redirect_path, only: :show

  def show
    @category = Category.find(params[:id])
    @items = @category.items.order("created_at DESC").includes(:user)
  end

  private

  def redirect_path
    category = Category.find(params[:id])
    if category.id == 1
      redirect_to root_path
    end
  end
end
