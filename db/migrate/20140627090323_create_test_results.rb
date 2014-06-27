class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.float :percentage, default: 0.00
      t.string :grade
      t.boolean :outcome, default: false
      t.text :remarks
      t.references :subject, index: true
      t.references :student, index: true
      t.references :class_test, index: true
      t.references :school_branch, index: true
      t.references :class_room, index: true
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
