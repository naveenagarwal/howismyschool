class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :document_type
      t.string :recorded_ids, array: true, default: []
      t.references :creator, polymorphic: true, index: true
      t.references :school_branch, index: true

      t.timestamps
    end
  end
end
