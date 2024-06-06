FactoryBot.define do
    factory :review do
      tittle { "Great Product" }
      description { "This product has great features." }
      calification { 4 }
      product
      user
    end
  end
  