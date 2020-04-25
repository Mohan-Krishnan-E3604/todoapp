class Board < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  belongs_to :user

  validates_presence_of :name, :user_id
end
