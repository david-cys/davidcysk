FactoryGirl.define do
  factory :profile do
    location "Test location"
    tagline "Test tagline"
    description "Test description"
    user
  end
end
