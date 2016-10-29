require "rails_helper"

RSpec.describe UsersController, type: :controller do

  # before do
  #   create :user
  #   post login_path, user: attributes_for(:user)
  # end

  describe "before_action" do
    it { is_expected.to use_before_action(:set_user) }
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        post :create, user: attributes_for(:user)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(User.count).to eq 1
        expect(json_response[:firstname]).to eq "TJ"
        expect(json_response[:email]).to eq "ex@ex.com"
      end
    end

    context "with invalid parameters" do
      it "fails to create a new user" do
        post :create, user: { firstname: nil }
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(User.count).to eq 0
        expect(json_response[:firstname]).to eq nil
        expect(json_response[:error]).to eq "User not created try again"
      end
    end
  end

  describe "GET #show" do
    before { create :user }
    it "renders the selected user" do
      get :show, id: 1
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:firstname]).to eq "TJ"
      expect(json_response[:id]).to eq 1
      expect(json_response[:id]).to eq User.first.id
    end
  end

  describe "PUT #update" do
    before { create :user }
    context "with valid parameters" do
      it "updates selected user" do
        put :update, id: 1, user: { firstname: "Taris", password: "1234567" }
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response[:firstname]).to eq "Taris"
        expect(User.first.firstname).to eq "Taris"
        expect(json_response[:id]).to eq 1
      end
    end

    context "with invalid parameters" do
      it "fails to update selected user" do
        put :update, id: 1, user: { firstname: nil }
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(User.first.firstname).to_not eq nil
        expect(json_response[:error]).to eq "User not updated try again"
      end
    end
  end

  describe "DELETE #destroy" do
    before { create :item }
    it "destroys the selected user" do
      delete :destroy, id: 1
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:firstname]).to eq nil
      expect(User.count).to eq 0
      expect(json_response[:message]).to eq "User deleted"
    end
  end

end
