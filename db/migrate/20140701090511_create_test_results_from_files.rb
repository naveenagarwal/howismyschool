class CreateTestResultsFromFiles < ActiveRecord::Migration
  def change
    create_table :test_results_from_files do |t|
      t.string :name
      t.references :school_branch, index: true
      t.string :test_result_ids, array: true, default: []
      t.integer :status
      t.text :status_msg
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
