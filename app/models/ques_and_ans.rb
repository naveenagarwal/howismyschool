class QuesAndAns < ActiveRecord::Base
  belongs_to :mock_test
  belongs_to :creator, polymorphic: true
end
