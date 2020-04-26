class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :created_at, :updated_at
  has_many :lists
end

