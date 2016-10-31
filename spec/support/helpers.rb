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
      post "/api/v1/bucketlists", { bucketlist: attributes_for(:bucketlist) }, auth_header
      auth_header
    end

    def create_item
      auth_header = create_bucketlist
      post "/api/v1/bucketlists/1/items", { item: attributes_for(:item) }, auth_header
      auth_header
    end

    def invalid_token
      create :user
      user_token = JsonWebToken.encode(user_id: 1, iss: "123")
      { "Authorization" => user_token }
    end
  end
end
