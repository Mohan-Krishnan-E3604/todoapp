module RedisHelper
  def todo_item_key(id)
    "TODO:ITEM:#{id}"
  end
end
