class SchoolBranch < ActiveRecord::Base
  belongs_to :school
  has_one :school_controller
  has_many :teachers
  has_many :subjects
  has_many :students
  has_many :class_rooms

end
