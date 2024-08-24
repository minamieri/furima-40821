FactoryBot.define do
  factory :product do
    association :user
    productname { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    category_id { Faker::Number.between(from: 2, to: 10) }
    status_id { Faker::Number.between(from: 2, to: 10) }
    delivery_charge_id { Faker::Number.between(from: 2, to: 10) }
    area_id { Faker::Number.between(from: 2, to: 47) }
    day_id { Faker::Number.between(from: 2, to: 10) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |product|
      product.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png',
                           content_type: 'image/png')
    end
  end
end
