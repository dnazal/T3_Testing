# spec/factories/solicituds.rb
FactoryBot.define do
    factory :solicitud do
      status { "Pendiente" }
      stock { 10 }
      reservation_info { "Solicitud de reserva para el día 01/01/2024, a las 10:00 hrs" }
      association :user
      association :product
    end
  end
  