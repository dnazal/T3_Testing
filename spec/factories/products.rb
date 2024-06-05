# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    nombre { "Product Name" }
    precio { 1000 }
    stock { 10 }
    categories { 'Accesorio tecnologico' }
    association :user
  end
end

  