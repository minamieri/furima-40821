FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birthday              { [Date.new(1980, 1, 1), Date.new(1990, 5, 15), Date.new(2000, 12, 31)].sample }
    full_width_lastname   { Faker::Name.last_name.gsub(/\w/, 'あ') }
    full_width_firstname  { Faker::Name.first_name.gsub(/\w/, 'あ') }
    katakana_lastname     { ('ア'..'ン').to_a.sample(3).join }
    katakana_firstname { ('ア'..'ン').to_a.sample(3).join }
  end
end
