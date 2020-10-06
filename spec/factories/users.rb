FactoryBot.define do
  factory :user do
    transient do
      person {Gimei.name}
    end
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    first_name_kanji { person.first.kanji }
    last_name_kanji { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    birthday {Faker::Date.backward}
  end
end