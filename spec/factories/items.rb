FactoryGirl.define do
  factory :item do
    bucketlist_id { create(:bucketlist).id }
    name "MyItems"
    done false

    trait(:bucketlist2) do
      bucketlist_id { create(:bucketlist, :user1).id }
    end
  end
end
