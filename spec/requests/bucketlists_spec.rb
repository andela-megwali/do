require "rails_helper"

RSpec.describe "Bucketlists", type: :request do
  before do
    create :user
    create_bucketlist
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new bucketlist" do
        expect(response).to have_http_status(:success)
        expect(Bucketlist.count).to eq 1
        expect(json_response[:name]).to eq "MyBucketlist"
        expect(json_response[:items]).to eq []
        expect(json_response[:created_by]).to eq "TJ"
      end
    end

    context "with invalid parameters" do
      it "fails to create a new bucketlist" do
        post(
          bucketlists_path,
          { bucketlist: { name: nil } },
          authorization_header(1)
        )
        expect(response).to have_http_status(400)
        expect(Bucketlist.count).to eq 1
        expect(json_response[:name]).to_not eq "MyBucketlist"
        expect(json_response[:error]).to eq "Bucketlist not created, try again"
      end
    end
  end

  describe "GET #index" do
    it "lists all the user's bucketlists" do
      get bucketlists_path, {}, authorization_header(1)
      expect(response).to have_http_status(:success)
      expect(json_response.first[:name]).to eq "MyBucketlist"
      expect(json_response.count).to eq Bucketlist.count
    end
  end

  describe "GET #show" do
    it "renders the selected bucketlist" do
      get bucketlist_path, {}, authorization_header(1)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq "MyBucketlist"
      expect(json_response[:id]).to eq 1
      expect(json_response[:id]).to eq Bucketlist.first.id
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      it "updates selected bucketlist" do
        put(
          bucketlist_path,
          { name: "Tari" },
          authorization_header(1)
        )
        expect(response).to have_http_status(:success)
        expect(json_response[:name]).to eq "Tari"
        expect(Bucketlist.first.name).to eq "Tari"
        expect(json_response[:id]).to eq 1
        expect(json_response[:created_by]).to eq "TJ"
      end
    end

    context "with invalid parameters" do
      it "fails to update selected bucketlist" do
        put(
          bucketlist_path,
          { name: nil },
          authorization_header(1)
        )
        expect(response).to have_http_status(400)
        expect(Bucketlist.first.name).to_not eq nil
        expect(Bucketlist.first.name).to eq "MyBucketlist"
        expect(json_response[:error]).to eq "Bucketlist not updated, try again"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the selected bucketlist" do
      delete bucketlist_path, {}, authorization_header(1)
      expect(response).to have_http_status(:success)
      expect(json_response[:name]).to eq nil
      expect(Bucketlist.count).to eq 0
      expect(json_response[:message]).to eq "Bucketlist deleted"
    end
  end
end
