class CreateMyDetails < ActiveRecord::Migration
  def change
    create_table :my_details do |t|
      t.references :whoami, polymorphic: true, index: true
      t.references :school_branch, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone
      t.string :emergency_contact
      t.string :address_temporary
      t.string :address_permamnent

      t.timestamps
    end
  end
end
