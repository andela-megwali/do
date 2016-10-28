FactoryGirl.define do
  factory :bucketlist do
    user_id { create(:user).id }
    name "MyBucketlist"
  end
end
