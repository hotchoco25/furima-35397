FactoryBot.define do
  factory :user do
    transient do
      jp_name { Gimei.name }
    end
    nickname { Faker::Name.initials }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6)}
    password_confirmation { password }
    last_name { jp_name.last.kanji }
    first_name { jp_name.first.kanji }
    last_kana { jp_name.last.katakana }
    first_kana { jp_name.first.katakana }
    birth { Faker::Date.birthday(min_age: 4,max_age: 90)}
  end
end
