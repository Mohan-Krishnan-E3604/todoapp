class List < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # 1:m relationship with Item model
  has_many :items, dependent: :destroy
  belongs_to :user

  # model validations
  validates_presence_of :title, :created_by
end
