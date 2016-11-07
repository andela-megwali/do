class ItemSerializer < ActiveModel::Serializer
  include SerializerHelper

  attributes :id, :name, :date_created, :date_modified, :done
end
