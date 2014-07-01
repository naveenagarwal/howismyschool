# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_results_from_file do
    name "MyString"
    school_branch nil
    test_result_ids "MyString"
    status 1
    creator nil
  end
end
