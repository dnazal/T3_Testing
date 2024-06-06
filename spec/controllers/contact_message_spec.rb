# spec/controllers/contact_message_spec.rb
require 'rails_helper'

RSpec.describe ContactMessageController, type: :controller do
  let(:admin_user) { create(:user, role: 'admin') }
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: 'John Doe', mail: 'john@example.com', title: 'Consulta', body: 'Necesito más información.' } }
  let(:invalid_attributes) { { name: '', mail: '', title: '', body: '' } }
  let!(:contact_message) { create(:contact_message, valid_attributes) }

  before do
    sign_in admin_user
  end

  describe "PATCH #actualizar" do
    context "with valid params" do
      it "updates the requested contact message" do
        patch :actualizar, params: { id: contact_message.id, contact_message: { body: "Nuevo contenido" } }
        contact_message.reload
        expect(contact_message.body).to eq("Nuevo contenido")
      end
    end

    context "with invalid params" do
      it "does not update the contact message" do
        patch :actualizar, params: { id: contact_message.id, contact_message: { body: "" } }
        contact_message.reload
        expect(contact_message.body).not_to eq("")
      end
    end
  end

  describe "DELETE #eliminar" do
    context "when user is not admin" do
      before do
        sign_out admin_user
        sign_in user
      end

      it "does not delete the contact message" do
        contact_message_to_delete = create(:contact_message)
        expect {
          delete :eliminar, params: { id: contact_message_to_delete.id }
        }.to change(ContactMessage, :count).by(0)
      end
    end

    context "when user is admin" do
      it "deletes the contact message" do
        contact_message_to_delete = create(:contact_message)
        expect {
          delete :eliminar, params: { id: contact_message_to_delete.id }
        }.to change(ContactMessage, :count).by(-1)
      end
    end
  end
end
