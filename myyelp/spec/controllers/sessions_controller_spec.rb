require 'spec_helper'

describe SessionsController do

  describe "GET new" do

    it "redirects to home page if logged in" do
      set_current_user
      get :new
      expect(response).to redirect_to(home_path)
    end

    it "renders new sign in page if not logged in" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do

    context "valid input" do
      let(:user) { Fabricate(:user) }
      before { post :create, email: user.email, password: user.password }

      it "creates new session" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to home page" do
        expect(response).to redirect_to(home_path)
      end
    end
    
    context "invalid input" do
      it_behaves_like "require_sign_in" do
        let!(:action) { post :create }
      end
    end
  end
end