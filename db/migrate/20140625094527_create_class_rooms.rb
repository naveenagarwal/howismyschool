class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :name
      t.references :creator, polymorphic: true, index: true
      t.references :school, index: true
      t.references :school_branch, index: true
      t.string :grade

      t.timestamps
    end
  end
end
