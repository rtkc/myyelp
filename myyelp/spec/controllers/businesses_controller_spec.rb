require 'spec_helper'

describe BusinessesController do

  describe "GET show" do

    context "authenticated user" do
      before do
        set_current_user
        @business = Fabricate(:business)
      end
      
      it "sets @business" do 
        get :show, id: @business.id
        expect(assigns(:business)).to eq(@business)
      end

      it "sets @reviews" do
        review1 = Fabricate(:review, business_id: @business.id)
        review2 = Fabricate(:review, business_id: @business.id)
        get :show, id: @business.id
        expect(assigns(:reviews)).to include(review1, review2)
      end
    end

    context "unauthenticated user" do

      it_behaves_like "require_sign_in" do
        business = Fabricate(:business)
        let!(:action) { get :show, id: business.id }
      end
    end
  end

  describe "POST create" do

    context "authenticated user" do
      before { set_current_user }

      context "valid input" do
        before { post :create, business: Fabricate.attributes_for(:business, category_id: 1) }

        it "saves business record" do
          expect(Business.count).to eq(1)
        end

        it "associates new business record with correct category" do
          expect(Business.first.category_id).to eq(1)
        end

        it "redirects to business profile page if record successfully saved" do
          expect(response).to redirect_to(business_path(Business.first))
        end
      end

      context "invalid input" do
        before { post :create, business: {name: "Motorino"} }

        it "does not save business record" do 
          expect(Business.count).to eq(0)
        end

        it "renders new business page again" do
          expect(response).to render_template :new
        end
      end
    end

    context "unauthenticated user" do

      it "does not save business record" do
        post :create, business: Fabricate.attributes_for(:business)
        expect(Business.count).to eq(0)
      end
      
      it_behaves_like "require_sign_in" do
        let!(:action) { post :create, business: Fabricate.attributes_for(:business) }
      end
    end
  end
end