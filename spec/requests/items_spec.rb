require "rails_helper"

RSpec.describe "Items", type: :request do
  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new item" do
        create_item
        expect(response).to have_http_status(:success)
        expect(Item.count).to eq 1
        expect(json_response[:id]).to eq 1
        expect(json_response[:name]).to eq "MyItems"
        expect(json_response[:done]).to eq false
      end
    end

    context "with invalid parameters" do
      it "fails to create a new item" do
        post items_path, { item: { name: nil } }, create_bucketlist
        expect(response).to have_http_status(:success)
        expect(Item.count).to eq 0
        expect(json_response[:name]).to_not eq "MyItems"
        expect(json_response[:error]).to eq "Item not created, try again"
      end
    end
  end

  describe "GET #index" do
    it "lists all items in the selected bucketlist" do
      get items_path, {}, create_item
      expect(response).to have_http_status(:success)
      expect(json_response.first[:name]).to eq "MyItems"
      expect(json_response.count).to eq Item.count
    end
  end

  describe "GET #show" do
    it "renders the selected item" do
      get item_path, {}, create_item
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq "MyItems"
      expect(json_response[:id]).to eq 1
      expect(json_response[:id]).to eq Item.first.id
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      it "updates selected item" do
        put item_path, { item: { name: "Taris" } }, create_item
        expect(response).to have_http_status(:success)
        expect(json_response[:name]).to eq "Taris"
        expect(Item.first.name).to eq "Taris"
        expect(json_response[:id]).to eq 1
      end
    end

    context "with invalid parameters" do
      it "fails to update selected item" do
        put item_path, { item: { name: nil } }, create_item
        expect(response).to have_http_status(:success)
        expect(Item.first.name).to_not eq nil
        expect(json_response[:name]).to_not eq "MyItems"
        expect(json_response[:error]).to eq "Item not updated, try again"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the selected item" do
      delete item_path, {}, create_item
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq nil
      expect(Item.count).to eq 0
      expect(json_response[:message]).to eq "Item deleted"
    end
  end
end
