class TestResult < ActiveRecord::Base
  default_scope -> { order("") }

  belongs_to :subject
  belongs_to :student
  belongs_to :class_test
  belongs_to :school_branch
  belongs_to :class_room
  belongs_to :test_results_from_file
  belongs_to :creator, polymorphic: true

  validates :subject, :student, :class_test, :class_room, :percentage, :year, presence: true

  validates :percentage, numericality: { greater_than_or_equal_to: 0.00, less_than_or_equal_to: 100.00 }

  validates :student,
    uniqueness: {
      scope: [ :subject_id, :class_test_id, :class_room_id, :school_branch_id, :year ],
      message: "- This Test Result already fed into the system for this student."
    }

  before_save :check_student_belongs_to_right_class
  before_save :associate_details


  def pass_or_fail
    outcome? ? "Passed" : "Failed"
  end

  def student_name_only
    byebug
    student_name.split("-").first.squish
  end

  def student_rno_only
    student_name.split("-").last.squish
  end

  private

  def check_student_belongs_to_right_class
    if !class_room.students.where(id: student_id).exists?
      self.errors.add(:student, "The selected Student does not belongs to this class room - #{class_room.full_name}/#{class_room.id}/#{student_id}")
      false
    end
  end

  def associate_details
    self.class_room_name  = class_room.full_name
    self.class_test_name  = class_test.name
    self.student_name     = student.name_with_rno
    self.subject_name     = subject.name
  end
end
