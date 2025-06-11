class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]
  before_action :set_item, only: [:show, :edit, :update]

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
  end

  def edit
    # ここからセッションに保存された入力値を復元のための記述
    return unless session[:item_edit_params]

    @item.assign_attributes(session[:item_edit_params])
    session[:item_edit_errors]&.each do |attr, messages|
      messages.each do |msg|
        @item.errors.add(attr, msg)
      end
    end
    session.delete(:item_edit_params)
    session.delete(:item_edit_errors)
    # ここまでセッションに保存された入力値を復元のための記述
  end

  def update
    # ここからセッションに保存された入力値を復元のための記述
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      session[:item_edit_params] = item_params.to_h
      session[:item_edit_errors] = @item.errors.messages
      redirect_to edit_item_path(@item)
    end
    # ここまでセッションに保存された入力値を復元のための記述
  end

  private

  def move_to_index
    @item = Item.find(params[:id])
    return if current_user == @item.user

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :shipping_payer_id, :duration_id,
                                 :prefecture_id, :image)
  end
end
