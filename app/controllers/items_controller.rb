class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_path, only: [:edit, :update, :destroy]
  before_action :redirect_path_sold, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:index, :show]

  def index
    @items = Item.order("created_at DESC").includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:item)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path, method: :get
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name, :text, :category_id, :status_id, :pay_id, :area_id, :day_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def redirect_path
    if @item.user_id != current_user.id
      redirect_to action: :index
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_path_sold
    if @item.record.present?
      redirect_to root_path
    end
  end

  def set_category
    @categories = Category.all
  end
end
