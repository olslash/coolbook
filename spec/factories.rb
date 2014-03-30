FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "user@example.com"
    password "coolmitch"
    password_confirmation "coolmitch"
  end
end