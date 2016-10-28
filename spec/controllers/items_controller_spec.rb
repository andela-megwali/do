require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :controller do
  # let(:token) { double acceptable?: true }
  # before do
  #   allow(controller).to receive(:doorkeeper_token) { token }
  # end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new item" do
        post :create, item: attributes_for(:item), bucketlist_id: 1
        json_response = JSON.parse(response.body, symbolize_names: true)
        binding.pry
        expect(response).to have_http_status(:success)
        expect(Item.count).to eq 1
        expect(json_response[:id]).to eq 1
        expect(json_response[:name]).to eq "MyItems"
        expect(json_response[:done]).to eq false
      end
    end

    context "with invalid parameters" do
      it "fails to create a new item" do
        post :create, item: { name: nil }, bucketlist_id: 1
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(Item.count).to eq 0
        expect(json_response[:name]).to_not eq "MyItems"
        expect(json_response[:error]).to eq "Item not created try again"
      end
    end
  end

  describe "GET #index" do
    before { create :item }
    it "lists all items in the selected bucketlist" do
      get :index, bucketlist_id: 1
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response.first[:name]).to eq "MyItems"
      expect(json_response.count).to eq Item.count
    end
  end

  describe "GET #show" do
    before { create :item }
    it "renders the selected bucketlist" do
      get :show, id: 1, bucketlist_id: 1
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq "MyItems"
      expect(json_response[:id]).to eq 1
      expect(json_response[:id]).to eq Item.first.id
    end
  end

  describe "PUT #update" do
    before { create :item }
    context "with valid parameters" do
      it "updates selected bucketlist" do
        put :update, id: 1, item: { name: "Taris" }, bucketlist_id: 1
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response[:name]).to eq "Taris"
        expect(Item.first.name).to eq "Taris"
        expect(json_response[:id]).to eq 1
      end
    end

    context "with invalid parameters" do
      it "fails to update selected bucketlist" do
        put :update, id: 1, item: { name: nil }, bucketlist_id: 1
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(Item.first.name).to_not eq nil
        expect(json_response[:name]).to_not eq "MyItems"
        expect(json_response[:error]).to eq "Item not updated try again"
      end
    end
  end

  describe "DELETE #destroy" do
    before { create :item }
    it "destroys the selected bucketlist" do
      delete :destroy, id: 1, bucketlist_id: 1
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq nil
      expect(Item.count).to eq 0
      expect(json_response[:message]).to eq "Item deleted"
    end
  end
end
