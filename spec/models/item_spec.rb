require 'rails_helper'

RSpec.describe Item, type: :model do
  include RedisHelper

  let(:item) { create(:item) }

  it { should belong_to(:list) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }

  it 'should clear redis cache after save' do
    REDIS.set(todo_item_key(item.id), item.to_json)
    item.save
    expect(REDIS.get(todo_item_key(item.id))).to be_falsey
  end
end
