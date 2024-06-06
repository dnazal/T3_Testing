# spec/controllers/reviews_spec.rb
require 'rails_helper'

RSpec.describe ReviewController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:review) { create(:review, product: product, user: user) }
  let(:valid_attributes) { { tittle: 'Buena', description: 'Muy buena', calification: 4 } }
  let(:invalid_attributes) { { tittle: '', description: '', calification: nil } }

  before do
    sign_in user
  end

  describe "POST #insertar" do
    context "with valid params" do
      it "creates a new Review" do
        expect {
          post :insertar, params: { review: valid_attributes, product_id: product.id }
        }.to change(Review, :count).by(1)
      end

      it "redirects to the product page" do
        post :insertar, params: { review: valid_attributes, product_id: product.id }
        expect(response).to redirect_to("/products/leer/#{product.id}")
      end
    end

    context "with invalid params" do
      it "does not create a new Review" do
        expect {
          post :insertar, params: { review: invalid_attributes, product_id: product.id }
        }.to change(Review, :count).by(0)
      end
    end
  end

  describe "PATCH #actualizar_review" do
    context "with valid params" do
      it "updates the requested review" do
        patch :actualizar_review, params: { id: review.id, review: { tittle: 'Excelente' } }
        review.reload
        expect(review.tittle).to eq('Excelente')
      end
    end

    context "with invalid params" do
      it "does not update the review" do
        patch :actualizar_review, params: { id: review.id, review: { tittle: '' } }
        review.reload
        expect(review.tittle).not_to eq('')
      end
    end
  end

  describe "DELETE #eliminar" do
    it "destroys the requested review" do
      review_to_delete = create(:review, product: product, user: user)
      expect {
        delete :eliminar, params: { id: review_to_delete.id }
      }.to change(Review, :count).by(-1)
    end
  end
end
