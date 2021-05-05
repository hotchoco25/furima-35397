class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_path_mine, only: [:index, :create]
  before_action :redirect_path_sold, only: [:index, :create]

  def index
    @record_buy = RecordBuy.new
  end

  def create
    @record_buy = RecordBuy.new(record_params)
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_path_mine
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def redirect_path_sold
    if @item.record.present?
      redirect_to root_path
    end
  end
end
