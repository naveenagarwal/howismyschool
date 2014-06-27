class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.references :school_branch, index: true
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
