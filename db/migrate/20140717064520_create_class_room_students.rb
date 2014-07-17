class CreateClassRoomStudents < ActiveRecord::Migration
  def change
    create_table :class_room_students do |t|
      t.references :class_room, index: true
      t.references :student, index: true
      t.string :year
      t.references :school_branch, index: true
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
