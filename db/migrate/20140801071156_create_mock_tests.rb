class CreateMockTests < ActiveRecord::Migration
  def change
    create_table :mock_tests do |t|
      t.references :school_branch, index: true
      t.references :creator, polymorphic: true, index: true
      t.string :name
      t.references :class_room, index: true

      t.timestamps
    end
  end
end
