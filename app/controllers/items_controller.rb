class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
    # ここからセッションに保存された入力値を復元のための記述
    if session[:item_params]
      @item = Item.new(session[:item_params])
      # エラー情報も復元
      session[:item_errors]&.each do |attr, messages|
        messages.each do |msg|
          @item.errors.add(attr, msg)
        end
      end
      session.delete(:item_params)
      session.delete(:item_errors)
    else
      @item = Item.new
    end
    # ここまでセッションに保存された入力値を復元のための記述
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :shipping_payer_id, :duration_id,
                                 :prefecture_id, :image)
  end
end
