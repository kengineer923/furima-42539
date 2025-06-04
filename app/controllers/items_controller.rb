class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index_unless_owner, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
    @categories = Category.all
    @conditions = Condition.all
    @shipping_payers = ShippingPayer.all
    @durations = Duration.all
    @prefectures = Prefecture.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @categories = Category.all
    @conditions = Condition.all
    @shipping_payers = ShippingPayer.all
    @durations = Duration.all
    @prefectures = Prefecture.all
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      @categories = Category.all
      @conditions = Condition.all
      @shipping_payers = ShippingPayer.all
      @durations = Duration.all
      @prefectures = Prefecture.all
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :shipping_payer_id, :duration_id, :prefecture_id, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index_unless_owner
    redirect_to root_path unless user_signed_in? && current_user == @item.user
  end
end
