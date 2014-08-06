class QuesAndAns < ActiveRecord::Base

  ANSWER_TYPE = ["Mulitple Choice", "Single choice", "Subjecttive"]

  belongs_to :mock_test
  belongs_to :creator, polymorphic: true

  has_many :mock_test_takens
end
