class Item < ActiveRecord::Base
  include RedisHelper

  belongs_to :list
  belongs_to :user
  # model validations
  validates_presence_of :name

  after_save :clear_cache

  def clear_cache
    REDIS.del(todo_item_key(id))
  end
end
