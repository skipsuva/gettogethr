require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) {
    User.create(name: 'Rspec Testman', password: 'password', email: 'test@example.com')
  }

  let(:valid_attributes) {
    { email: 'test@example.com', password: 'password' }
  }

  let(:invalid_attributes) {
    { email: 'def not an email!', password: '' }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user session" do
        new_user = user
        post :create, {:user => valid_attributes}
        expect(@controller.logged_in?).to be_truthy
      end

      it "redirects to the created gathering" do
        new_user = user
        post :create, {:user => valid_attributes}
        expect(response).to redirect_to(gatherings_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved gathering as @gathering" do
        post :create, {:user => invalid_attributes}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end
end
