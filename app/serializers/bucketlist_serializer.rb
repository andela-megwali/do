class BucketlistSerializer < ActiveModel::Serializer
  include SerializerHelper

  attributes :id, :name, :items, :date_created, :date_modified, :created_by
  has_many :items
end
