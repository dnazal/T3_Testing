# spec/controllers/users_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:image) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg'), 'image/jpeg') }

  describe "GET #show" do
    context "for unauthenticated user" do
      it "redirects to login" do
        get :show, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "for authenticated user" do
      before do
        sign_in user
      end

      it "renders the :show template" do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    end
  end

  describe "GET #deseados" do
    context "for unauthenticated user" do
      it "redirects to login" do
        get :deseados
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "for authenticated user" do
      before do
        sign_in user
      end

      it "renders the :deseados template" do
        get :deseados
        expect(response).to be_successful
      end
    end
  end

  describe "GET #mensajes" do
    context "for unauthenticated user" do
      it "redirects to login" do
        get :mensajes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "for authenticated user" do
      before do
        sign_in user
      end

      it "renders the :mensajes template" do
        get :mensajes
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #actualizar_imagen" do
    context "for authenticated user" do
      before do
        sign_in user
      end

      it "updates the user's image" do
        patch :actualizar_imagen, params: { image: image }
        user.reload
        expect(user.image.attached?).to be(true)
        expect(flash[:notice]).to eq('Imagen actualizada correctamente')
        expect(response).to redirect_to(user_show_path)
      end

      it "does not update the image if the file type is incorrect" do
        invalid_image = fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test.txt'), 'text/plain')
        patch :actualizar_imagen, params: { image: invalid_image }
        expect(flash[:error]).to eq('Hubo un error al actualizar la imagen. Verifique que la imagen es de formato jpg, jpeg, png, gif o webp')
        expect(response).to redirect_to(user_show_path)
      end
    end

    context "for unauthenticated user" do
      it "redirects to login" do
        patch :actualizar_imagen, params: { image: image }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #eliminar_deseado" do
    context "for authenticated user" do
      before do
        sign_in user
        user.deseados << '1'
        user.save
      end

      it "removes the product from the user's wishlist" do
        expect {
          delete :eliminar_deseado, params: { deseado_id: '1' }
          user.reload
        }.to change { user.deseados.count }.by(-1)
        expect(flash[:notice]).to eq('Producto quitado de la lista de deseados')
        expect(response).to redirect_to(user_deseados_path)
      end
    end

    context "for unauthenticated user" do
      it "redirects to login" do
        delete :eliminar_deseado, params: { deseado_id: '1' }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
