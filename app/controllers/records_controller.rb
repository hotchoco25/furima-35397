class RecordsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @record_buy = RecordBuy.new
  end

  def create
    @record_buy = RecordBuy.new(record_params)
    @item = Item.find(params[:item_id])
    if @record_buy.valid?
      pay_item
      @record_buy.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def record_params
    params.require(:record_buy).permit(
      :post_code, :area_id, :muni, :add, :buil, :tel
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: @record_buy.token,
        currency: 'jpy'
      )
  end

end
