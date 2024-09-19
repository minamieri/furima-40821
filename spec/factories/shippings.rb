FactoryBot.define do
  factory :shipping do
    post_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    area_id        { Faker::Number.between(from: 2, to: 48) }
    city           { Faker::Address.city }
    address        { Faker::Address.street_address }
    building_name  { Faker::Address.secondary_address }
    tel            { Faker::Number.leading_zero_number(digits: 11) }
    association :order_history
  end
end
