FactoryGirl.define do
  factory :post do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph(2)
    association :user
  end
end
