require 'spec_helper'

describe ReviewsController do

  describe "GET index" do
    context "authenticated user" do
      before { set_current_user }
      it "returns all review objects" do
        review1 = Fabricate(:review)
        review2 = Fabricate(:review)
        review3 = Fabricate(:review)
        get :index
        expect(assigns(:reviews)).to include(review1, review2, review3)
      end

      it "returns all review objects in reverse chronological order" do
        review1 = Fabricate(:review, created_at: 1.day.ago)
        review2 = Fabricate(:review, created_at: 2.day.ago)
        review3 = Fabricate(:review, created_at: 3.day.ago)
        get :index
        expect(assigns(:reviews)).to eq([review1, review2, review3])
      end
    end

    context "unauthenticated user" do
      it_behaves_like "require_sign_in" do
        let!(:action) { get :index}
      end
    end
  end

  describe "POST create" do
    let(:business) { Fabricate(:business) }

    context "authenticated user" do
      before { set_current_user }

      context "valid input" do
        before { post :create, business_id: business.id, review: Fabricate.attributes_for(:review) }
        
        it "sets @business" do
          expect(assigns(:business)).to eq(business)
        end
        
        it "creates new review record" do
          expect(Review.count).to eq(1)
        end
        
        it "associates new review with correct business item record" do
          expect(Review.first.business).to eq(business)
        end

        it "redirects to show business path of current business object" do
          expect(response).to redirect_to(business_path(business))
        end

        it "creates a review associated with the signed in user" do
          expect(Review.first.creator).to eq(current_user)
        end
      end

      context "invalid input" do
        before { post :create, business_id: business.id, review: Fabricate.attributes_for(:review, rating: '', review: '') }

        it "does not create new review record" do
          expect(Review.count).to eq(0)
        end

        it "renders new business show page" do
          expect(response).to render_template "businesses/show"
        end
      end
    end

    context "unauthenticated users" do
      
      it "does not create new review record" do
        post :create, business_id: business.id, review: Fabricate.attributes_for(:review)
        expect(Review.count).to eq(0)
      end

      it_behaves_like "require_sign_in" do
        let!(:action) { post :create, business_id: business.id, review: Fabricate.attributes_for(:review) }
      end
    end
  end
end