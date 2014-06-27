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

  class << self
    def get_students_array_for_select_option(school_branch_id: nil)
      select(:id, :name, :roll_number).
      where(
          school_branch_id: school_branch_id
        ).
      map { |p| [ p.name_with_rno, p.id ] }
    end
  end

  def name_with_rno
    "#{name.titleize} - #{roll_number}"
  end
end
