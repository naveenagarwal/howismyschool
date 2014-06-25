class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.hstore :regestrar_details
      t.references :school_controller, index: true
      t.references :manager, index: true

      t.timestamps
    end
  end
end
