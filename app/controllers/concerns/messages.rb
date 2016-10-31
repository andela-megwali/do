module Concerns
  module Messages
    def not_created
      "#{controller_name.singularize.capitalize} not created, try again"
    end

    def not_updated
      "#{controller_name.singularize.capitalize} not updated, try again"
    end

    def delete_successful
      "#{controller_name.singularize.capitalize} deleted"
    end

    def not_permitted
      "You do not own that #{controller_name.singularize.capitalize}"
    end
  end
end