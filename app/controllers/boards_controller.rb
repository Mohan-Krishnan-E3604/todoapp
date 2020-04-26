class BoardsController < ApplicationController

  before_action :set_board, only: [:show, :update, :destroy]


  # GET /boards
  def index
    boards = @current_user.boards
    json_response(boards)
  end

  # POST /boards
  def create
    @board = @current_user.boards.create!(board_params)
    json_response(@board)
  end

  # PATCH /boards/:id
  def update
    @board.update(board_params)
    head :no_content
  end

  # GET /boards/:id
  def show
    render json: @board, include: [
        lists: [
            :items
        ]
    ], status: :ok
  end

  # DELETE /boards/:id
  def destroy
    @board.destroy
    head :no_content
  end

  private

  def board_params
    params.permit(:name, :locale)
  end

  def set_board
    @board = @current_user.boards.find_by!(id: params[:id])
  end

end
