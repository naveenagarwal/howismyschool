# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ques_and_an, :class => 'QuesAndAns' do
    question "MyText"
    answer_type 1
    answer_choices ""
    right_answer ""
    mock_test nil
    creator nil
  end
end
