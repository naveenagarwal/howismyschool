class TestResult < ActiveRecord::Base
  default_scope -> { order("") }

  belongs_to :subject
  belongs_to :student
  belongs_to :class_test
  belongs_to :school_branch
  belongs_to :class_room
  belongs_to :creator, polymorphic: true

  validates :subject, :student, :class_test, :class_room, :percentage, :year, presence: true

  validates :percentage, numericality: { greater_than_or_equal_to: 0.00, less_than_or_equal_to: 100.00 }

  validates :student,
    uniqueness: {
      scope: [ :subject_id, :class_test_id, :class_room_id, :school_branch_id, :year ],
      message: "- This Test Result already fed into the system for this student."
    }

  before_save :check_student_belongs_to_right_class

  private

  def check_student_belongs_to_right_class
    if class_room.students.where(id: student_id).exists?
      self.errors.add(:student, "The selected Student does not belongs to this class room")
      false
    end
  end
end
