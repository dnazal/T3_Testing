# spec/factories/shopping_carts.rb
FactoryBot.define do
    factory :shopping_cart do
      user
  
      # Suponiendo que 'products' es un hash de product_id y cantidad
      # Simulamos la adición de productos al carro de compras con IDs ficticios y cantidades
      products { { Faker::Number.between(from: 1, to: 10).to_s => Faker::Number.between(from: 1, to: 5) } }
    end
  end
  