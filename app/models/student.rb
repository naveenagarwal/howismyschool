class Student < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school_branch
  belongs_to :class_room

  validates :name, :roll_number, :class_room_id, presence: true
  validates :name, :roll_number,
    uniqueness: {
      scope: [ :class_room_id, :roll_number ],
      message: " - This student already exists with same name and roll number"
    }

end
