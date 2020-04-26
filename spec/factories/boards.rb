FactoryBot.define do
  factory :board do
    name { Faker::Lorem.word }
    user_id { 123 }
  end
end

