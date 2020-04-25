class User < ActiveRecord::Base

  has_many :lists, foreign_key: :created_by
  has_many :items
  has_many :boards

  has_secure_password
  validates_presence_of :name, :email, :password_digest
end
