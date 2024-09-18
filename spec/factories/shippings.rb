FactoryBot.define do
  factory :shipping do
    post_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    # post_code      { Faker::Address.zip_code }
    # post_code      { Faker::Address.zip_code(state_abbreviation: 'JP') }
    area_id        { Faker::Number.between(from: 2, to: 48) }
    city           { Faker::Address.city }
    address        { Faker::Address.street_address }
    building_name  { Faker::Address.secondary_address }
    tel            { Faker::Number.leading_zero_number(digits: 11) }
    association :order_history
  end
end

# post_code      { '123-4567' }
# area_id        { 2 }
# city           { '横浜市' }
# address        { '青山1-1-1' }
# building_name  { '柳ビル103' }
# tel            { '09012345678' }
# association    :order_history
# end
# end
