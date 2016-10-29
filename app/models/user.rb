class User < ActiveRecord::Base
  has_secure_password
  has_many :bucketlists
  validates_presence_of :password, :firstname, :lastname, :email
  validates_uniqueness_of :email
end
