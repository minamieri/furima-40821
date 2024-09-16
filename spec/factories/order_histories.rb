FactoryBot.define do
  factory :order_history do
    association :user
    association :product
  end
end
