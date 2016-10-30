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

    def invalid_token
      create :user
      user_token = JsonWebToken.encode(user_id: 1, iss: "123")
      { "Authorization" => user_token }
    end
  end
end
