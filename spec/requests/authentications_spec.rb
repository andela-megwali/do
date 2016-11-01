require "rails_helper"

RSpec.describe "Authentications", type: :request do
  describe "POST #login" do
    before { create :user }

    context "with valid login credentials" do
      before { post "/auth/login", user: attributes_for(:user) }

      it "assigns and renders a jwt authentication token" do
        expect(response).to have_http_status(200)
        expect(json_response[:auth_token]).to_not eq nil
      end

      it "creates token with valid user_id and iss key" do
        decoded_token = JsonWebToken.decode(json_response[:auth_token])
        expect(decoded_token).to have_key :user_id
        expect(decoded_token[:user_id]).to eq User.first.id
        expect(decoded_token).to have_key :iss
        expect(decoded_token[:iss]).to eq User.first.iss
      end
    end

    context "with invalid login credentials" do
      it "refuses user authorization" do
        post "/auth/login", user: { email: nil }
        expect(response).to have_http_status(401)
        expect(json_response[:auth_token]).to eq nil
        expect(json_response[:error]).to eq "Invalid Credentials Detected"
      end
    end
  end

  describe "GET #logout" do
    context "with valid jwt token" do
      it "returns logout success message" do
        auth_header = set_authorization_header
        get "/auth/logout", {}, auth_header
        expect(response).to have_http_status(200)
        expect(json_response[:message]).
          to eq "User logged out of all active sessions"
      end

      it "invalidates all active jwt tokens" do
        auth_header = set_authorization_header
        get "/auth/logout", {}, auth_header
        decoded_token = JsonWebToken.decode(auth_header["Authorization"])
        expect(decoded_token[:user_id]).to eq User.first.id
        expect(decoded_token).to have_key :iss
        expect(decoded_token[:iss]).to_not eq User.first.iss
      end
    end
  end

  describe "prevent unauthorized use of authenticated tokens" do
    context "with a tampered token" do
      it "rejects all token requests" do
        get user_path(1), {}, tampered_token
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end

    context "with valid token" do
      it "disallows access to other user's information" do
        create_bucketlist
        post users_path, user: attributes_for(:user, :user2)
        wale = User.find(2)
        user_token = JsonWebToken.encode(user_id: wale.id, iss: wale.iss)
        auth_header = { "Authorization" => user_token }
        get bucketlist_path, {}, auth_header
        expect(json_response[:error]).to eq "You do not own that Bucketlist"
      end
    end
  end
end
