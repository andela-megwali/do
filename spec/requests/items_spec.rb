require 'rails_helper'

RSpec.describe "Items", type: :request do
  user_token = JsonWebToken.encode(user_id: 1)
  auth_header = { "Authorization" => user_token }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        post users_path, user: attributes_for(:user)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(User.count).to eq 1
        expect(json_response[:firstname]).to eq "TJ"
        expect(json_response[:email]).to eq "ex@ex.com"
      end
    end

    context "with invalid parameters" do
      it "fails to create a new user" do
        post users_path, user: { firstname: nil }
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
    context "when user is authorized" do
      it "renders the selected user" do
        get user_path(1), {}, auth_header
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response[:firstname]).to eq "TJ"
        expect(json_response[:id]).to eq 1
        expect(json_response[:id]).to eq User.first.id
      end
    end

    context "when user is not authorized" do
      it "returns unauthorized error message" do
        get user_path(1), {}, nil
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end

  describe "PUT #update" do
    before { create :user }
    context "with valid parameters" do
      it "updates selected user" do
        put user_path(1), { user: { firstname: "Taris", password: "1234567" } }, auth_header
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response[:firstname]).to eq "Taris"
        expect(User.first.firstname).to eq "Taris"
        expect(json_response[:id]).to eq 1
      end
    end

    context "with invalid parameters" do
      it "fails to update selected user" do
        put user_path(1), { user: { firstname: nil } }, auth_header
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
      delete user_path(1), {}, auth_header
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:firstname]).to eq nil
      expect(User.count).to eq 0
      expect(json_response[:message]).to eq "User deleted"
    end
  end
end
