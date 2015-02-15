FactoryGirl.define do
  factory :profile do
    location "Test location"
    tagline "Test tagline"
    sequence(:description){ |n| "Test description(#{n})" }
    sequence(:name){ |n| "tester name_#{n}" }
    user

    factory :profile_with_avatar do
      avatar_file_name { 'test.jpg' }
      avatar_content_type { 'image/jpg' }
      avatar_file_size { 1024 }
    end
  end
end
