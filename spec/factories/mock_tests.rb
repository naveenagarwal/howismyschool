# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mock_test do
    school_branch nil
    creator nil
    name "MyString"
    class_room nil
  end
end
