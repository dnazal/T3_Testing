# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      name { Faker::Name.first_name }  # Generalmente, el primer nombre no excede los 25 caracteres.
      email { Faker::Internet.email }
      password { 'Password1!' }
      role { ['user', 'admin'].sample }  # Ejemplo si manejas roles
    end
  end
  