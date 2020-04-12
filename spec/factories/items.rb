FactoryBot.define do
  factory :item do
    name { Faker::Movies::HarryPotter.character }
    completed { false }
    todo_id { nil }
  end
end
