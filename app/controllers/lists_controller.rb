class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]
  before_action :set_board, only: [:create]

  # GET /lists
  def index
    @lists = current_user.lists
    json_response(@lists)
  end

  # POST /lists
  def create
    @list = @board.lists.create!(todo_params.merge({created_by: @current_user.id}))
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
    params.permit(:title, :locale, :board_id)
  end

  def query_parms
    params.permit(:query)
  end

  def set_list
    @list = @current_user.lists.find_by!(id: params[:id])
  end

  def set_board
    @board = @current_user.boards.find_by!(id: params[:boardId])
  end

end
