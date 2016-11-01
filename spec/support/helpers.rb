module Helpers
  module RequestHelper
    def json_response
      JSON.parse(response.body, symbolize_names: true)
    end

    def set_authorization_header
      smith = create :user
      user_token = JsonWebToken.encode(user_id: smith.id, iss: smith.iss)
      { "Authorization" => user_token }
    end

    def create_bucketlist
      auth_header = set_authorization_header
      post(
        bucketlists_path,
        { bucketlist: attributes_for(:bucketlist) },
        auth_header
      )
      auth_header
    end

    def create_item
      auth_header = create_bucketlist
      post(
        items_path,
        { item: attributes_for(:item) },
        auth_header
      )
      auth_header
    end

    def tampered_token
      auth_header = set_authorization_header
      { "Authorization" => auth_header["Authorization"][0, 10] }
    end

    def bucketlist_path
      "/api/v1/bucketlists/1"
    end

    def bucketlists_path
      "/api/v1/bucketlists"
    end

    def item_path
      "/api/v1/bucketlists/1/items/1"
    end

    def items_path
      "/api/v1/bucketlists/1/items"
    end
  end
end
