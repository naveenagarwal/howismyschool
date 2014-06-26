class SchoolBranch < ActiveRecord::Base
  belongs_to :school
  has_one :school_controller
  has_many :teachers
end
