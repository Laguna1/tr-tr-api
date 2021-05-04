FactoryBot.define do
    factory :track do
      name { Faker::Esport.game }
      done { Faker::Boolean.boolean }
      train_id { nil }
    end
  end