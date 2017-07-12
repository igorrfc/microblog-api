FactoryGirl.define do
  factory :follow do
    association :followee, factory: :user
    association :follower, factory: :user
  end
end
