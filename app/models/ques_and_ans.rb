class QuesAndAns < ActiveRecord::Base
  belongs_to :mock_test
  belongs_to :creator, polymorphic: true

  has_many :mock_test_takens
end
