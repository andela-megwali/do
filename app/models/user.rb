class User < ActiveRecord::Base
  has_secure_password
  has_many :bucketlists

  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create

  before_save :generate_issue_number

  private

  def generate_issue_number
    invalid_number = issue_number
    self.issue_number = rand(100..999).to_s while issue_number == invalid_number
  end
end
