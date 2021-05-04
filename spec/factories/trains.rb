FactoryBot.define do
  factory :train do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
  end
end
