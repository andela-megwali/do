FactoryGirl.define do
  factory :bucketlist do
    name "MyBucketlist"

    trait(:bucketlist2) do
      name "OtherBucketlist"
      user_id 1
    end
  end
end
