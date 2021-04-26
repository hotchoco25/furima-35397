class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(
      :item_name, :text, :category_id, :status_id, :pay_id, :area_id, :day_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
