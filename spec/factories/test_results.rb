# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_result do
    percentage 1.5
    grade "MyString"
    outcome false
    remarks "MyText"
    subject nil
    student nil
    class_test nil
    school_branch nil
    class_room ""
    creator nil
  end
end
