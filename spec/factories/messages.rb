# spec/factories/messages.rb
FactoryBot.define do
  factory :message do
    body { "This is a test message" }
    association :product
    association :user
  end
end