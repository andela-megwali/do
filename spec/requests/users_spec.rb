require "rails_helper"

RSpec.describe "Users", type: :request do
  before { create :user }

  describe "POST /users" do
    context "with valid parameters" do
      it "creates a new user" do
        post users_path, attributes_for(:user, :user2)
        expect(response).to have_http_status(:success)
        expect(User.count).to eq 2
        expect(json_response[:firstname]).to eq "TJ"
        expect(json_response[:email]).to eq "we@we.com"
      end
    end

    context "with invalid parameters" do
      it "fails to create a new user" do
        post users_path, firstname: nil
        expect(response).to have_http_status(400)
        expect(User.count).to eq 1
        expect(json_response[:firstname]).to eq nil
        expect(json_response[:error]).to eq "User not created, try again"
      end
    end
  end

  describe "PUT /users/1" do
    context "with valid parameters" do
      it "updates selected user" do
        put(
          user_path(1),
          { firstname: "Taris", password: "1234567" },
          authorization_header(1)
        )
        expect(response).to have_http_status(:success)
        expect(json_response[:firstname]).to eq "Taris"
        expect(User.first.firstname).to eq "Taris"
        expect(json_response[:id]).to eq 1
      end
    end

    context "with invalid parameters" do
      it "fails to update selected user" do
        put user_path(1), { firstname: nil }, authorization_header(1)
        expect(response).to have_http_status(400)
        expect(User.first.firstname).to_not eq nil
        expect(json_response[:error]).to eq "User not updated, try again"
      end
    end
  end

  describe "DELETE /users/1" do
    it "destroys the selected user" do
      delete user_path(1), {}, authorization_header(1)
      expect(response).to have_http_status(:success)
      expect(json_response[:firstname]).to eq nil
      expect(User.count).to eq 0
      expect(json_response[:message]).to eq "User deleted"
    end
  end
end
