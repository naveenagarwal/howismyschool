class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :roll_number
      t.references :class_room
      t.references :school_branch
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
