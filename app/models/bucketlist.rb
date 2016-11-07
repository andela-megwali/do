class Bucketlist < ActiveRecord::Base
  extend Paginate

  belongs_to :user
  has_many :items

  validates_presence_of :name

  scope :search, lambda { |name_query|
    where("lower(name) LIKE ?", "%#{name_query.downcase if name_query}%")
  }
end
