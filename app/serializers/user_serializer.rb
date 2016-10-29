class UserSerializer < ActiveModel::Serializer
  include SerializerHelper

  attributes :firstname, :lastname, :email, :date_modified, :user_message
end
