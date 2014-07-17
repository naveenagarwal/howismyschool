class ClassRoomStudent < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :student
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true

  validates :class_room_id, :student_id, :school_branch_id, :year, presence: true

  validates :student_id, uniqueness: {
    scope: [:school_branch_id, :class_room_id, :year],
    message: "~ Student is already present in this class for this year"
  }

end
