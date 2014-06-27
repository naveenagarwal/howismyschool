class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name, index: true
      t.string :roll_number, index: true
      t.references :class_room, index: true
      t.references :school_branch, index: true
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
