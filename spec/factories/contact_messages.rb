# spec/factories/contact_messages.rb
FactoryBot.define do
    factory :contact_message do
      title { "Consulta General" }
      body { Faker::Lorem.paragraph }
      name { Faker::Name.name }
      mail { Faker::Internet.email }
      phone { "+56123456789" } # Ejemplo de formato esperado
    end
  end
  