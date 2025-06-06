class ItemsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  # before_action :set_item, only: [:show, :edit, :update, :destroy]
  # before_action :move_to_index_unless_owner, only: [:edit, :update, :destroy]

  # def index
  #   @items = Item.includes(:user).order(created_at: :desc)
  # end

  def new
    @item = Item.new
    # if session[:item_params]
    #   @item = Item.new(session[:item_params])
    #   # エラー情報も復元
    #   session[:item_errors]&.each do |attr, messages|
    #     messages.each do |msg|
    #       @item.errors.add(attr, msg)
    #     end
    #   end
    #   session.delete(:item_params)
    #   session.delete(:item_errors)
    # else
    #   @item = Item.new
    # end
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      # 入力値・エラーをセッションに保存してリダイレクト
      session[:item_params] = item_params.to_h
      session[:item_errors] = @item.errors.messages
      redirect_to new_item_path
    end
  end

  # def show
  #   @item = Item.find(params[:id])
  # end

  # def edit
  #   set_item
  # end

  # def update
  #   if @item.update(item_params)
  #     redirect_to item_path(@item)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @item.destroy
  #   redirect_to root_path
  # end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :shipping_payer_id, :duration_id,
                                 :prefecture_id, :image)
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end

  # def move_to_index_unless_owner
  #   redirect_to root_path unless user_signed_in? && current_user == @item.user
  # end
end
