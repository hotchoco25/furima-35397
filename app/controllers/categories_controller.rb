class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @items = @category.items.order("created_at DESC").includes(:user)
  end
end
