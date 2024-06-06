# spec/controllers/message_controller_spec.rb
require 'rails_helper'

RSpec.describe MessageController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:message) { create(:message, product: product, user: user) }
  let(:valid_attributes) { { body: 'This is a test message', product_id: product.id } }
  let(:invalid_attributes) { { body: '' } }

  describe "GET #leer" do
    context "for authenticated user" do
      before do
        sign_in user
      end

      it "returns a success response" do
        get :leer, params: { id: message.id }
        expect(response).to be_successful
      end
    end
  end


  describe "POST #insertar" do
    context "with valid params" do
      it "creates a new Message" do
        sign_in user
        expect {
          post :insertar, params: { message: valid_attributes, product_id: product.id }
        }.to change(Message, :count).by(1)
      end
    end

    context "with invalid params" do
      it "does not create a new Message" do
        sign_in user
        expect {
          post :insertar, params: { message: invalid_attributes, product_id: product.id }
        }.to change(Message, :count).by(0)
      end
    end
  end

  describe "DELETE #eliminar" do
    context "for authenticated user" do
      before do
        sign_in user
      end

      it "deletes the requested message" do
        message = create(:message, product: product, user: user)
        expect {
          delete :eliminar, params: { message_id: message.id, product_id: product.id }
        }.to change(Message, :count).by(-1)
      end
    end
  end
end
