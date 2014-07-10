# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :my_detail do
    whoami nil
    school_branch nil
    first_name "MyString"
    middle_name "MyString"
    last_name "MyString"
    phone "MyString"
    emergency_contact "MyString"
    address_temporary "MyString"
    address_permamnent "MyString"
  end
end
