FactoryBot.define do
  factory :item do
    name { Faker::Movies::HarryPotter.character }
    completed { false }
    list_id { nil }
    user_id { nil }
  end
end
