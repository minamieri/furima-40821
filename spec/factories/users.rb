FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birthday              { [Date.new(1980, 1, 1), Date.new(1990, 5, 15), Date.new(2000, 12, 31)].sample }
    full_width_lastname   { '初音' }
    full_width_firstname  { '未来' }
    katakana_lastname     { 'ハツネ' }
    katakana_firstname    { 'ミク' }
  end
end
