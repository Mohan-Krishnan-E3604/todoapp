class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /lists
  def index
    @lists = List.all
    json_response(@lists)
  end

  # POST /lists
  def create
    @list = List.create!(todo_params)
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

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def set_list
    @list = List.find(params[:id])
  end
end