class SchoolBranch < ActiveRecord::Base
  belongs_to :school
  has_one :school_controller
  has_many :teachers
  has_many :subjects
end
