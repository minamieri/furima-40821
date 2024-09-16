FactoryBot.define do
  factory :shipping do
    post_code      { '123-4567' }
    area_id        { 2 }
    city           { '横浜市' }
    address        { '青山1-1-1' }
    building_name  { '柳ビル103' }
    tel            { '09012345678' }
    association    :order_history
  end
end
