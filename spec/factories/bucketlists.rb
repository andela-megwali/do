FactoryGirl.define do
  factory :bucketlist do
    user_id { create(:user, :user2).id }
    name "MyBucketlist"
  end
end
