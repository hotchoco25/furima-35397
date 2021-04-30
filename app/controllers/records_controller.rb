class RecordsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
  end

  private

  def record_params
    params.require(:record).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
