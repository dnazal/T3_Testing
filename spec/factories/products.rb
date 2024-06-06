# spec/factories/products.rb
FactoryBot.define do
    factory :product do
      nombre { Faker::Commerce.product_name }
      precio { Faker::Commerce.price(range: 10..100.0) }
      stock { Faker::Number.between(from: 1, to: 100) }
      categories { ['Cancha'].sample }
      user # Asume que un product siempre pertenece a un usuario
    end
  end
  
  