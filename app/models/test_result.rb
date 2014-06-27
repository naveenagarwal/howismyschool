class TestResult < ActiveRecord::Base
  belongs_to :subject
  belongs_to :student
  belongs_to :class_test
  belongs_to :school_branch
  belongs_to :class_room
  belongs_to :creator, polymorphic: true

  validates :subject, :student, :class_test, :class_room, :percentage, presence: true

  validates :student,
    uniqueness: {
      scope: [ :subject_id, :class_test_id, :class_room_id, :school_branch_id ],
      message: "- This Test Result already fed into the system for this student."
    }

end
