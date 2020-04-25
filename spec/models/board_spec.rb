require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should have_many(:lists).dependent(:destroy) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:user_id) }
end
