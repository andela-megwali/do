class User < ActiveRecord::Base
  has_secure_password
  has_many :bucketlists

  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create

  before_save :generate_iss_number

  private

  def generate_iss_number
    self.iss = rand(100..999).to_s
  end
end
