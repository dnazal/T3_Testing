# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    name { "John Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      role { "admin" }
    end
  end
end
