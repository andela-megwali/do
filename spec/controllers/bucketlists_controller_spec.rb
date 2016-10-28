require "rails_helper"

RSpec.describe Api::V1::BucketlistsController, type: :controller do
  # let(:token) { double acceptable?: true }
  # before do
  #   allow(controller).to receive(:doorkeeper_token) { token }
  # end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new bucketlist" do
        session[:user_id] = 1
        post :create, bucketlist: attributes_for(:bucketlist)
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
        session[:user_id] = 1
        post :create, bucketlist: { name: nil }
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
      get :index
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response.first[:name]).to eq "MyBucketlist"
      expect(json_response.count).to eq Bucketlist.count
    end
  end

  describe "GET #show" do
    before { create :item }
    it "renders the selected bucketlist" do
      get :show, id: 1
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
        put :update, id: 1, bucketlist: { name: "Taris" }
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
        put :update, id: 1, bucketlist: { name: nil }
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(Bucketlist.first.name).to_not eq nil
        expect(json_response[:name]).to_not eq "MyBucketlist"
        expect(json_response[:error]).to eq "Bucketlist not updated try again"
      end
    end
  end

  describe "DELETE #destroy" do
    before { create :item }
    it "destroys the selected bucketlist" do
      delete :destroy, id: 1
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq nil
      expect(Bucketlist.count).to eq 0
      expect(json_response[:message]).to eq "Bucketlist deleted"
    end
  end
end
