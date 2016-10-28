FactoryGirl.define do
  factory :item do
    bucketlist_id { create(:bucketlist).id }
    name "MyItems"
    done false
  end
end
