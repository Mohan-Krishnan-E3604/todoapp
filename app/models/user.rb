class User < ActiveRecord::Base
  searchkick word_start: [:name]
  has_many :lists, foreign_key: :created_by
  has_many :items
  has_many :boards

  has_secure_password
  validates_presence_of :name, :email, :password_digest
end
