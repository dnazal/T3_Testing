require 'rails_helper'

# spec/controllers/products_spec.rb
RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let(:product) { create(:product, user: user) }
  let(:valid_attributes) {
    { nombre: 'Nuevo Producto', precio: 20, stock: 10, categories: 'Accesorio deportivo', user_id: user.id }
  }
  let(:invalid_attributes) {
    { nombre: '', precio: -10, stock: -5, categories: '', user_id: nil }
  }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #leer" do
    it "returns a success response" do
      get :leer, params: { id: product.id }
      expect(response).to be_successful
    end
  end

  describe "GET #crear" do
    it "returns a success response" do
      get :crear
      expect(response).to be_successful
    end
  end

  describe "POST #insertar" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :insertar, params: { product: valid_attributes }
          @product = assigns(:product) # Captura la instancia de @product después del post
          if @product.errors.any?
            puts "Product creation errors: #{@product.errors.full_messages.to_sentence}"
          end
        }.to change(Product, :count).by(1)
      end

      it "redirects to the product list" do
        post :insertar, params: { product: valid_attributes }
        expect(response).to redirect_to('/products/index')
      end
    end

    context "with invalid params" do
      it "does not create a new Product" do
        expect {
          post :insertar, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end
    end
  end

  describe "PATCH #actualizar_producto" do
    context "with valid params" do
      let(:new_attributes) {
        { nombre: 'Producto Actualizado', precio: 25, stock: 15, categories: 'Accesorio de vestir' }
      }

      it "updates the requested product" do
        patch :actualizar_producto, params: { id: product.id, product: new_attributes }
        product.reload
        expect(product.nombre).to eq('Producto Actualizado')
        expect(product.precio.to_f).to eq(25.0)
        expect(product.stock.to_i).to eq(15)
        expect(product.categories).to eq('Accesorio de vestir')
      end

      it "redirects to the product list" do
        patch :actualizar_producto, params: { id: product.id, product: new_attributes }
        expect(response).to redirect_to('/products/index')
      end
    end

    context "with invalid params" do
      it "does not update the product" do
        patch :actualizar_producto, params: { id: product.id, product: invalid_attributes }
        product.reload
        expect(product.nombre).to_not eq('')
        expect(product.precio.to_f).to_not eq(-10.0)
        expect(product.stock.to_i).to_not eq(-5)
        expect(product.categories).to_not eq('')
      end
    end
  end

  describe "DELETE #eliminar" do
    it "destroys the requested product" do
      product_to_delete = create(:product, user: user)
      expect {
        delete :eliminar, params: { id: product_to_delete.id }
      }.to change(Product, :count).by(-1)
    end
  end
end
