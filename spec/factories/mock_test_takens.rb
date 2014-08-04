# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mock_test_taken do
    mock_test nil
    student nil
    ques_and_ans nil
    answer_given ""
  end
end
