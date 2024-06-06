# spec/controllers/solicitud_controller_spec.rb
require 'rails_helper'

RSpec.describe SolicitudController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:solicitud) { create(:solicitud, product: product, user: user) }
  let(:valid_attributes) { { stock: 5, reservation_datetime: '2024-01-01 10:00' } }
  let(:invalid_attributes) { { stock: '', reservation_datetime: '' } }

  describe "GET #index" do
    context "for authenticated user" do
      before do
        sign_in user
      end

      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe "POST #insertar" do
    context "with valid params" do
      it "creates a new Solicitud" do
        sign_in user
        expect {
          post :insertar, params: { solicitud: valid_attributes, product_id: product.id }
        }.to change(Solicitud, :count).by(1)
      end
    end

    context "with invalid params" do
      it "does not create a new Solicitud" do
        sign_in user
        expect {
          post :insertar, params: { solicitud: invalid_attributes, product_id: product.id }
        }.to change(Solicitud, :count).by(0)
      end
    end
  end

  describe "PATCH #actualizar" do
    context "with valid params" do
      it "updates the requested solicitud" do
        sign_in user
        patch :actualizar, params: { id: solicitud.id, solicitud: { status: 'Aprobada' } }
        solicitud.reload
        expect(solicitud.status).to eq('Aprobada')
      end
    end

    context "with invalid params" do
      it "does not update the solicitud" do
        sign_in user
        patch :actualizar, params: { id: solicitud.id, solicitud: { stock: '' } }
        solicitud.reload
        expect(solicitud.stock).not_to eq('')
      end
    end
  end

  describe "DELETE #eliminar" do
    context "for authenticated user" do
      before do
        sign_in user
      end

      it "deletes the requested solicitud" do
        solicitud = create(:solicitud, product: product, user: user)
        expect {
          delete :eliminar, params: { id: solicitud.id }
        }.to change(Solicitud, :count).by(-1)
      end
    end
  end
end
