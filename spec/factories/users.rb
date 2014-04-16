# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jhon_doe_user, :class => User do
    name "Jhon Doe"
    email "jhon.doe@skeleton.com"
    profile "admin"
    password "MyString"
    confirmed_at { Time.new(2013, 5, 20) }
  end
end
