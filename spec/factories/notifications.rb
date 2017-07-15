FactoryGirl.define do
  factory :notification do
    message Faker::Lorem.paragraph(1)
    association :user
  end
end
