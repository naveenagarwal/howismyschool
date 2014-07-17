# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_room_student do
    class_room nil
    student nil
    year "MyString"
    school_branch nil
    creator nil
  end
end
