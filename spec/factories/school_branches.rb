# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school_branch do
    name "MyString"
    address "MyText"
    city "MyString"
    state "MyString"
    zip "MyString"
  end
end
