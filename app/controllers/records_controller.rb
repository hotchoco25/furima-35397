class RecordsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @record_buy = RecordBuy.new
  end

  def create
    @record_buy = RecordBuy.new(record_params)
    if @record_buy.valid?
      @record_buy.save
      redirect_to item_path(item.id)
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def record_params
    params.require(:record_buy).permit(:post_code, :area_id, :muni, :add, :buil, :tel).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
