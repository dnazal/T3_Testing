# spec/factories/products.rb

FactoryBot.define do
  factory :product do
    sequence(:nombre) { |n| "Producto #{n}" }
    precio { 1000 }
    stock { 10 }
    categories { "Accesorio tecnologico" }
    association :user
  end
end


  