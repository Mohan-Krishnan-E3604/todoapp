require 'rails_helper'

RSpec.describe Item, type: :model do

  it { should belong_to(:list) }

  it { should validate_presence_of(:name) }

end
