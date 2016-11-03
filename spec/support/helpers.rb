module Helpers
  module RequestHelper
    def json_response
      JSON.parse(response.body, symbolize_names: true)
    end

    def authorization_header(id)
      smith = User.find(id)
      user_token = JsonWebToken.encode(user_id: smith.id, iss: smith.iss)
      { "Authorization" => user_token }
    end

    def create_bucketlist
      post(
        bucketlists_path,
        attributes_for(:bucketlist),
        authorization_header(1)
      )
    end

    def create_item
      post(
        items_path,
        attributes_for(:item),
        authorization_header(1)
      )
    end

    def decoded_token
      JsonWebToken.decode(json_response[:auth_token])
    end

    def tampered_token
      auth_header = authorization_header(1)
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
