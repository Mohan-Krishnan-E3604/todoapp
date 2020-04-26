class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_by, :created_at, :updated_at, :board_id
  has_many :items
end
