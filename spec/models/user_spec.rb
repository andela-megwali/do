require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }
  it { is_expected.to have_many(:bucketlists) }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
end
