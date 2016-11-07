FactoryGirl.define do
  factory :user do
    password "1234567"
    firstname "TJ"
    lastname  "Smith"
    email "ex@ex.com"
    issue_number "123"

    trait(:user2) do
      email "we@we.com"
    end
  end
end
