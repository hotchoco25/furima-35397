FactoryBot.define do
  factory :record_buy do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { '123-4567' }
    area_id { Faker::Number.within(range: 2..48) }
    muni { Faker::Address.city }
    add { Faker::Address.street_address }
    buil { Faker::Address.building_number }
    tel { Faker::Number.number(digits: 10) }
  end
end
