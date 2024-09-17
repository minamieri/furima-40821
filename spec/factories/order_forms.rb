FactoryBot.define do
  factory :order_form do
    post_code      { Faker::Address.zip_code }
    area_id        { Faker::Number.between(from: 2, to: 48) }
    city           { Faker::Address.city }
    address        { Faker::Address.street_address }
    building_name  { Faker::Address.secondary_address }
    tel            { Faker::Number.leading_zero_number(digits: 11) }
    user_id        { Faker::Number.between(from: 1, to: 100) }
    product_id     { Faker::Number.between(from: 1, to: 100) }
    token          { 'tok_abcdefghijk00000000000000000' }
    # post_code      { '123-4567' }
    # area_id        { 2 }
    # city           { '横浜市緑区' }
    # address        { '青山1-1-1' }
    # building_name  { '柳ビル103' }
    # tel            { '09012345678' }
    # user_id        { 1 }
    # product_id     { 1 }
    # association    :user
    # association    :product
  end
end
