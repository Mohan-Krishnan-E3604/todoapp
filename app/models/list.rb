class List < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # 1:m relationship with Item model
  has_many :items, dependent: :destroy

  # model validations
  validates_presence_of :title, :created_by
end
