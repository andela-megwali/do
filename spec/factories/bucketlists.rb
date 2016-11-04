FactoryGirl.define do
  factory :bucketlist do
    name "MyBucketlist"

    trait(:bucketlist2) do
      name "OtherBucketlist"
    end
  end
end
