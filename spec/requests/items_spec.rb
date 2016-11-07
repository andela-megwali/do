require "rails_helper"

RSpec.describe "Items", type: :request do
  before do
    create :user
    create_bucketlist
    create_item
  end

  describe "POST /api/v1/bucketlists/1/items" do
    context "with authorization header" do
      context "with valid parameters" do
        it "creates a new item" do
          expect(response).to have_http_status(:success)
          expect(Item.count).to eq 1
          expect(json_response[:id]).to eq 1
          expect(json_response[:name]).to eq "MyItems"
          expect(json_response[:done]).to eq false
        end
      end

      context "with invalid parameters" do
        it "fails to create a new item" do
          post items_path, { item: { name: nil } }, authorization_header(1)
          expect(response).to have_http_status(400)
          expect(Item.count).to eq 1
          expect(json_response[:name]).to_not eq "MyItems"
          expect(json_response[:error]).to eq "Item not created, try again"
        end
      end
    end

    context "with no valid authorization header" do
      it "returns unauthorized error" do
        post items_path, attributes_for(:item)
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end

  describe "GET /api/v1/bucketlists/1/items" do
    context "with authorization header" do
      before { 100.times { create_item } }

      context "with no pagination params" do
        it "defaults and returns only the bucketlist's first 20 items" do
          get items_path, {}, authorization_header(1)
          expect(response).to have_http_status(:success)
          expect(json_response.first[:name]).to eq "MyItems"
          expect(Item.count).to eq 101
          expect(json_response.count).to eq 20
          expect(json_response.first[:id]).to eq 1
          expect(json_response.last[:id]).to eq 20
        end
      end

      context "with invalid pagination params" do
        it "defaults and returns only the bucketlist's first 20 items" do
          get items_path, { page: -1, limit: -3 }, authorization_header(1)
          expect(response).to have_http_status(:success)
          expect(json_response.first[:name]).to eq "MyItems"
          expect(Item.count).to eq 101
          expect(json_response.count).to eq 20
          expect(json_response.first[:id]).to eq 1
          expect(json_response.last[:id]).to eq 20
        end
      end

      context "with pagination params and limit < 101" do
        it "returns item results limited by the pagination params" do
          get items_path, { page: 2, limit: 5 }, authorization_header(1)
          expect(response).to have_http_status(:success)
          expect(json_response.first[:name]).to eq "MyItems"
          expect(json_response.count).to eq 5
          expect(json_response.first[:id]).to eq 6
          expect(json_response.last[:id]).to eq 10
        end
      end

      context "with pagination params and limit > 100" do
        it "limits items returned to the first 100 on requested page" do
          get items_path, { page: 1, limit: 200 }, authorization_header(1)
          expect(response).to have_http_status(:success)
          expect(json_response.first[:name]).to eq "MyItems"
          expect(json_response.count).to eq 100
          expect(json_response.first[:id]).to eq 1
          expect(json_response.last[:id]).to eq 100
        end
      end
    end

    context "with no valid authorization header" do
      it "returns unauthorized error" do
        get items_path
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end

  describe "GET /api/v1/bucketlists/1/items/1" do
    context "with authorization header" do
      it "renders the selected item" do
        get item_path, {}, authorization_header(1)
        expect(response).to have_http_status(:success)
        expect(json_response[:name]).to eq "MyItems"
        expect(json_response[:id]).to eq 1
        expect(json_response[:id]).to eq Item.first.id
      end
    end

    context "with no valid authorization header" do
      it "returns unauthorized error" do
        get item_path
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end

  describe "PUT /api/v1/bucketlists/1/items/1" do
    context "with authorization header" do
      context "with valid parameters" do
        it "updates selected item" do
          put item_path, { name: "Taris" }, authorization_header(1)
          expect(response).to have_http_status(:success)
          expect(json_response[:name]).to eq "Taris"
          expect(Item.first.name).to eq "Taris"
          expect(json_response[:id]).to eq 1
        end
      end

      context "with invalid parameters" do
        it "fails to update selected item" do
          put item_path, { name: nil }, authorization_header(1)
          expect(response).to have_http_status(400)
          expect(Item.first.name).to_not eq nil
          expect(json_response[:name]).to_not eq "MyItems"
          expect(json_response[:error]).to eq "Item not updated, try again"
        end
      end
    end

    context "with no valid authorization header" do
      it "returns unauthorized error" do
        put item_path, name: "Taris"
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end

  describe "DELETE /api/v1/bucketlists/1/items/1" do
    context "with authorization header" do
      it "destroys the selected item" do
        delete item_path, {}, authorization_header(1)
        expect(response).to have_http_status(:success)
        expect(json_response[:name]).to eq nil
        expect(Item.count).to eq 0
        expect(json_response[:message]).to eq "Item deleted"
      end
    end

    context "with no valid authorization header" do
      it "returns unauthorized error" do
        delete item_path
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Not Authorized"
      end
    end
  end
end
