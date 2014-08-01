class SchoolBranch < ActiveRecord::Base
  belongs_to :school
  has_one :school_controller
  has_many :teachers
  has_many :subjects
  has_many :students
  has_many :class_rooms
  has_many :class_tests
  has_many :test_results
  has_many :documents
  has_many :schedules
  has_many :mock_tests
end
