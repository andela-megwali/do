require 'rails_helper'

RSpec.describe "Bucketlists", type: :request do
  user_token = JsonWebToken.encode(user_id: 1)
  auth_header = { "Authorization" => user_token }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new bucketlist" do
        post "/api/v1/bucketlists", { bucketlist: attributes_for(:bucketlist) }, auth_header
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(Bucketlist.count).to eq 1
        expect(json_response[:name]).to eq "MyBucketlist"
        expect(json_response[:items]).to eq []
        expect(json_response[:created_by]).to eq "TJ"
      end
    end

    context "with invalid parameters" do
      it "fails to create a new bucketlist" do
        create :user
        post "/api/v1/bucketlists", { bucketlist: { name: nil } }, auth_header
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(Bucketlist.count).to eq 0
        expect(json_response[:name]).to_not eq "MyBucketlist"
        expect(json_response[:error]).to eq "Bucketlist not created try again"
      end
    end
  end

  describe "GET #index" do
    before { create :item }
    it "lists all bucketlists" do
      get "/api/v1/bucketlists", {}, auth_header
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response.first[:name]).to eq "MyBucketlist"
      expect(json_response.count).to eq Bucketlist.count
    end
  end

  describe "GET #show" do
    before { create :item }
    it "renders the selected bucketlist" do
      get "/api/v1/bucketlists/1", {}, auth_header
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq "MyBucketlist"
      expect(json_response[:id]).to eq 1
      expect(json_response[:id]).to eq Bucketlist.first.id
    end
  end

  describe "PUT #update" do
    before { create :item }
    context "with valid parameters" do
      it "updates selected bucketlist" do
        put "/api/v1/bucketlists/1", { bucketlist: { name: "Taris" } }, auth_header
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response[:name]).to eq "Taris"
        expect(Bucketlist.first.name).to eq "Taris"
        expect(json_response[:items]).to_not eq []
        expect(json_response[:id]).to eq 1
        expect(json_response[:created_by]).to eq "TJ"
      end
    end

    context "with invalid parameters" do
      it "fails to update selected bucketlist" do
        put "/api/v1/bucketlists/1", { bucketlist: { name: nil } }, auth_header
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(Bucketlist.first.name).to_not eq nil
        expect(Bucketlist.first.name).to eq "MyBucketlist" 
        expect(json_response[:error]).to eq "Bucketlist not updated try again"
      end
    end
  end

  describe "DELETE #destroy" do
    before { create :item }
    it "destroys the selected bucketlist" do
      delete "/api/v1/bucketlists/1", {}, auth_header
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq nil
      expect(Bucketlist.count).to eq 0
      expect(json_response[:message]).to eq "Bucketlist deleted"
    end
  end
end
