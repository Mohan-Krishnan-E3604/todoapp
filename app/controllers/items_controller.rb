class ItemsController < ApplicationController
  include RedisHelper

  before_action :set_list, only: [:create]
  before_action :set_item, only: [ :show, :update, :destroy]

  # GET /items
  def index
    json_response(@current_user.items)
  end

  # GET /items/:id
  def show
    item = REDIS.get(todo_item_key(params[:id]))
    if item.blank?
      item = @item.to_json
      REDIS.setex(todo_item_key(params[:id]), 10.hour.to_i, item)
    end
    json_response(item)
  end

  # POST /items
  def create
    item = @list.items.create!(item_params)
    @current_user.items << item
    json_response(item, :created)
  end

  # PATCH /items/:id
  def update
    @item.update(item_params)
    if params[:listId].present? || @item.list_id != params[:listId]
      list = @current_user.lists.find_by!(id: params[:listId])
      list.items << @item
    end
    head :no_content
  end

  # DELETE /items/:id
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :completed, :locale)
  end

  def set_list
    @list = @current_user.lists.find_by!(id: params[:listId])
  end

  def set_item
    @item = @current_user.items.find_by!(id: params[:id])
  end
end
