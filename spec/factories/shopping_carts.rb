# spec/factories/shopping_carts.rb
FactoryBot.define do
    factory :shopping_cart do
      association :user
      products { {} } # Por defecto, el carrito estará vacío
    end
  end
  