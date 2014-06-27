# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "MyString"
    roll_number "MyString"
    class_room ""
    creator nil
  end
end
