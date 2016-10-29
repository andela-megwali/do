class UserSerializer < ActiveModel::Serializer
  include SerializerHelper

  attributes :id, :firstname, :lastname, :email, :date_modified, :user_message
end
