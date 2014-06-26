class CreateClassTests < ActiveRecord::Migration
  def change
    create_table :class_tests do |t|
      t.string :name
      t.references :school, index: true
      t.references :school_branch, index: true
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
