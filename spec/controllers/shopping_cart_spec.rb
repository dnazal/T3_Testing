# spec/controllers/shopping_cart_controller_spec.rb
require 'rails_helper'

RSpec.describe ShoppingCartController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:shopping_cart) { create(:shopping_cart, user: user, products: {}) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show
      expect(response).to be_successful
    end
  end

  describe "GET #details" do
    context "when the shopping cart has products" do
      before do
        shopping_cart.products[product.id.to_s] = 1
        shopping_cart.save
      end

      it "returns a success response" do
        get :details
        expect(response).to be_successful
      end
    end

    context "when the shopping cart is empty" do
      it "redirects to the shopping cart page with an alert" do
        get :details
        expect(response).to redirect_to('/carro')
        expect(flash[:alert]).to eq('No tienes productos que comprar.')
      end
    end

    context "when the user is not signed in" do
      before do
        sign_out user
      end

      it "redirects to the root path with an alert" do
        get :details
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Debes iniciar sesión para comprar.')
      end
    end
  end

  describe "POST #insertar_producto" do
    it "adds a product to the shopping cart" do
      expect {
        post :insertar_producto, params: { product_id: product.id, add: { amount: 1 } }
      }.to change { shopping_cart.reload.products.count }.by(1)
    end
  end

  describe "PATCH #comprar_ahora" do
    it "adds a product and redirects to details" do
      expect {
        post :comprar_ahora, params: { product_id: product.id, add: { amount: 1 } }
      }.to change { shopping_cart.reload.products.count }.by(1)
      expect(response).to redirect_to('/carro/detalle')
    end
  end

  describe "DELETE #eliminar_producto" do
    before do
      shopping_cart.products[product.id.to_s] = 1
      shopping_cart.save
    end

    it "removes a product from the shopping cart" do
      expect {
        delete :eliminar_producto, params: { product_id: product.id }
      }.to change { shopping_cart.reload.products.count }.by(-1)
    end
  end

  describe "POST #realizar_compra" do
    it "completes the purchase and redirects to solicitud index" do
      shopping_cart.products[product.id.to_s] = 1
      shopping_cart.save

      expect {
        post :realizar_compra
      }.to change(Solicitud, :count).by(1)

      expect(response).to redirect_to('/solicitud/index')
    end
  end

  describe "DELETE #limpiar" do
    before do
      shopping_cart.products[product.id.to_s] = 1
      shopping_cart.save
    end

    it "clears the shopping cart" do
      expect {
        delete :limpiar
      }.to change { shopping_cart.reload.products.count }.to(0)
    end
  end
end
