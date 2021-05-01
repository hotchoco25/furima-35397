class RecordsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @record = Record.new(record_params)
    @buy = Buy.new(buy_params)
    if @record.save && @buy.save
      redirect_to item_path(item.id)
    else
      render :index
    end
  end

  private

  def record_params
    params.require(:record).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def buy_params
    params.require(:buy).premit(:post_code, :area_id, :muni, :add, :buil, :tel).mergi(record_id: @record.id)
  end
end
