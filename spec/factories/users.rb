FactoryGirl.define do
  factory :user do
    name 'Foo'
    nickname 'foobar'
    email 'foo@bar.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end
