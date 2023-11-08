FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    username { Faker::Internet.username }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name}
  end

  trait :short_password do
    title { "12345" }
  end
end
