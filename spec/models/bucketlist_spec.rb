require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  it { is_expected.to have_many(:items) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:name) }

  describe ".search" do
    it "responds to search" do
      expect(Bucketlist).to respond_to(:search)
    end

    it "returns bucketlists that meet the search criteria" do
      create :user
      other = create(:bucketlist, :bucketlist2)
      10.times { create :bucketlist }
      other_search = Bucketlist.search("other")
      expect(Bucketlist.count).to eq 11
      expect(other_search.count).to eq 1
      expect(other_search.first.name).to_not eq create(:bucketlist).name
      expect(other_search.first.name).to eq other.name
      expect(other_search.first.name).to eq "OtherBucketlist"
    end
  end
end
