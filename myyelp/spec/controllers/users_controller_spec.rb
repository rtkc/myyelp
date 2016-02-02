require 'spec_helper' 

describe UsersController do

  describe "POST create" do 

    context "valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "saves user" do
        expect(User.count).to eq(1) 
      end

      it "creates session" do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it "redirects to home page" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "invalid input" do 
      before { post :create, user: { full_name: "Jim Bob" } }

      it "does not save user" do 
        expect(User.count).to eq(0) 
      end

      it "renders new sign in page" do
        expect(response).to render_template :new 
      end
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    context "authenticated user" do
      before { set_current_user(user) }

      it "renders show profile page" do
        get :show, id: user.id
        expect(response).to render_template :show
      end
    end

    context "unauthenticated user" do
      it_behaves_like "require_sign_in" do
        let!(:action) { get :show, id: user.id }
      end
    end
  end
end