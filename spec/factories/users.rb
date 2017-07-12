FactoryGirl.define do
  sequence(:email) { Faker::Internet.unique.email }

  factory :user do
    name 'Foo'
    nickname 'foobar'
    email
    password 'foobar'
    password_confirmation 'foobar'
  end
end
