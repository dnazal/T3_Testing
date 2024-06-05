# spec/models/shopping_cart_spec.rb
require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  let(:user) { create(:user) }
  let(:product1) { create(:product, precio: 1000, user: user) }
  let(:product2) { create(:product, precio: 2000, user: user) }
  let(:shopping_cart) { create(:shopping_cart, user: user, products: { product1.id => 2, product2.id => 1 }) }

  describe 'validaciones' do
    it 'es válido con productos' do
      expect(shopping_cart).to be_valid
    end

    it 'es válido sin productos' do
      shopping_cart.products = {}
      expect(shopping_cart).to be_valid
    end

    it 'no es válido sin un usuario' do
      shopping_cart.user = nil
      expect(shopping_cart).not_to be_valid
    end
  end

  describe '#precio_total' do
    it 'calcula el precio total correctamente' do
      expect(shopping_cart.precio_total).to eq(4000)
    end

    it 'devuelve 0 si no hay productos' do
      shopping_cart.products = {}
      expect(shopping_cart.precio_total).to eq(0)
    end
  end

  describe '#costo_envio' do
    it 'calcula el costo de envío correctamente' do
      expect(shopping_cart.costo_envio).to eq(1200)
    end

    it 'devuelve la tarifa fija si no hay productos' do
      shopping_cart.products = {}
      expect(shopping_cart.costo_envio).to eq(1000)
    end
  end
end
