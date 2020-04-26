FactoryBot.define do
  factory :list do
    title { Faker::Lorem.word }
    board_id { Faker::Number.number(8) }
    created_by { Faker::Number.number(8) }
  end
end
