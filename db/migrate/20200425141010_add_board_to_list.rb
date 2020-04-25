class AddBoardToList < ActiveRecord::Migration
  def change
    add_reference :lists, :board, index: true, foreign_key: true
  end
end
