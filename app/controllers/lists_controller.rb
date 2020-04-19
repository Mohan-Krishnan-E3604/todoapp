class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /lists
  def index
    @lists = current_user.lists
    json_response(@lists)
  end

  # POST /lists
  def create
    @list = current_user.lists.create!(todo_params)
    json_response(@list)
  end

  # PATCH /lists/:id
  def update
    @list.update(todo_params)
    head :no_content
  end

  # GET /lists/:id
  def show
    json_response(@list)
  end

  # DELETE /lists/:id
  def destroy
    @list.destroy
    head :no_content
  end

  # GET /lists/search
  def search
    records = List.search(query_parms[:query]).records.to_json
    json_response(records)
  end

  private

  def todo_params
    params.permit(:title, :locale)
  end

  def query_parms
    params.permit(:query)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
