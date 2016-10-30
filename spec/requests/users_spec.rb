require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        post users_path, user: attributes_for(:user)
        expect(response).to have_http_status(:success)
        expect(User.count).to eq 1
        expect(json_response[:firstname]).to eq "TJ"
        expect(json_response[:email]).to eq "ex@ex.com"
      end
    end

    context "with invalid parameters" do
      it "fails to create a new user" do
        post users_path, user: { firstname: nil }
        expect(response).to have_http_status(:success)
        expect(User.count).to eq 0
        expect(json_response[:firstname]).to eq nil
        expect(json_response[:error]).to eq "User not created try again"
      end
    end
  end

  describe "GET #show" do
    context "when user is authorized" do
      it "renders the selected user" do
        get user_path(1), {}, set_authorization_header
        expect(response).to have_http_status(:success)
        expect(json_response[:firstname]).to eq "TJ"
        expect(json_response[:id]).to eq 1
        expect(json_response[:id]).to eq User.first.id
      end
    end

    context "when user is not authorized" do
      before { create :user }
      it "returns unauthorized error message" do
        get user_path(1), {}, nil
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      it "updates selected user" do
        put user_path(1), { user: { firstname: "Taris", password: "1234567" } }, set_authorization_header
        expect(response).to have_http_status(:success)
        expect(json_response[:firstname]).to eq "Taris"
        expect(User.first.firstname).to eq "Taris"
        expect(json_response[:id]).to eq 1
      end
    end

    context "with invalid parameters" do
      it "fails to update selected user" do
        put user_path(1), { user: { firstname: nil } }, set_authorization_header
        expect(response).to have_http_status(:success)
        expect(User.first.firstname).to_not eq nil
        expect(json_response[:error]).to eq "User not updated try again"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the selected user" do
      delete user_path(1), {}, set_authorization_header
      expect(response).to have_http_status(:success)
      expect(json_response[:firstname]).to eq nil
      expect(User.count).to eq 0
      expect(json_response[:message]).to eq "User deleted"
    end
  end
end
