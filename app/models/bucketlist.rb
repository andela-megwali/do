class Bucketlist < ActiveRecord::Base
  extend Paginate

  belongs_to :user
  has_many :items

  validates_presence_of :name

  scope :search, lambda { |name|
    where("name LIKE ?", "%#{name}%")
  }
end
