# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    nombre { "Product Name" }
    descripcion { "Product Description" }
    precio { 9.99 }
    stock { 10 }

  end
end


  
  