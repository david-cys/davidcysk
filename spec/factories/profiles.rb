FactoryGirl.define do
  factory :profile do
    location "Test location"
    tagline "Test tagline"
    sequence(:description){ |n| "Test description(#{n})" }
    user
  end
end
