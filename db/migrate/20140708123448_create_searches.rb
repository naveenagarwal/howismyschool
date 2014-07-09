class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :text
      t.references :searcher, polymorphic: true, index: true
      t.text :result, array: true, default: []
      t.references :school_branch, index: true

      t.timestamps
    end
  end
end
