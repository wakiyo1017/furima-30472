FactoryBot.define do
  factory :item do
    association :user
    name {Faker::Name.name}
    description {Faker::Lorem.sentence}
    price {10000}
    category_id {2}
    state_id {2}
    shipping_charge_id {2}
    region_id {2}
    delivery_day_id {2}

    after(:build) do |photo|
      photo.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
