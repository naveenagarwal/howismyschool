class MockTestTaken < ActiveRecord::Base
  belongs_to :mock_test
  belongs_to :student
  belongs_to :ques_and_ans
end
