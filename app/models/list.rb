class List < ActiveRecord::Base
  searchkick
  # 1:m relationship with Item model
  has_many :items, dependent: :destroy
  belongs_to :user
  belongs_to :board

  # model validations
  validates_presence_of :title, :created_by
end
