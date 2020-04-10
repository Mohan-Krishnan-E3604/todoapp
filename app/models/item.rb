class Item < ActiveRecord::Base

  belongs_to :list

  # model validations
  validates_presence_of :name
end
