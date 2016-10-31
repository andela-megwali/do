class Item < ActiveRecord::Base
  extend Paginate

  belongs_to :bucketlist

  validates_presence_of :name, :bucketlist_id
end
