# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    name "MyString"
    creator nil
    school_branch nil
    documentable nil
  end
end
