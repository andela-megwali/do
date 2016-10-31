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

    def logout_message
      "User logged out of all active sessions"
    end

    def invalid_login_message
      "Invalid Credentials Detected"
    end
  end
end
