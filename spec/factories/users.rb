FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "tester#{n}@example.com" }
    password "password"

    factory :user_with_profile do
      after(:create) do |user|
        create(:profile, :user => user)
      end
    end
  end
end
