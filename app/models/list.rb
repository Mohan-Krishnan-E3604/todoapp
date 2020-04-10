class List < ActiveRecord::Base

  # 1:m relationship with Item model
  has_many :items, dependent: :destroy

  # model validations
  validates_presence_of :title, :created_by
end
