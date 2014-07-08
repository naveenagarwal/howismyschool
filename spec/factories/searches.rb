# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    text "MyString"
    searcher nil
    result "MyText"
    school_branch nil
  end
end
