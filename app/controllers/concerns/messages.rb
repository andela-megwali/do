module Concerns
  module Messages
    def not_created_message
      "#{controller_name.singularize.capitalize} not created, try again"
    end

    def not_updated_message
      "#{controller_name.singularize.capitalize} not updated, try again"
    end

    def delete_message
      "#{controller_name.singularize.capitalize} deleted"
    end

    def not_permitted_message
      "You do not own that #{controller_name.singularize.capitalize}"
    end

    def not_authorized_message
      "Not Authorized"
    end

    def login_message
      "Your token is valid for 2hours only, but you can logout any time before."
    end

    def logout_message
      "User logged out of all active sessions"
    end

    def invalid_login_message
      "Invalid Credentials Detected"
    end

    def not_permitted
      render json: { error: not_permitted_message }, status: 403
    end

    def not_updated
      render json: { error: not_updated_message }, status: 400
    end

    def not_created
      render json: { error: not_created_message }, status: 400
    end
  end
end
