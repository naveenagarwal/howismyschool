class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.references :comentator, polymorphic: true, index: true
      t.references :comment_for, polymorphic: true, index: true

      t.timestamps
    end
  end
end
