class AddDetailsToEntites < ActiveRecord::Migration
  def change

    add_column :teachers, :creator_id, :integer
    add_column :teachers, :creator_type, :string
    add_column :teachers, :school_id, :integer
    add_column :teachers, :school_branch_id, :integer

    add_column :school_controllers, :creator_id, :integer
    add_column :school_controllers, :creator_type, :string

    add_column :managers, :creator_id, :integer
    add_column :managers, :creator_type, :string

    add_index :teachers, :creator_id
    add_index :teachers, :creator_type
    add_index :teachers, :school_id
    add_index :teachers, :school_branch_id

    add_index :school_controllers, :creator_id
    add_index :school_controllers, :creator_type

    add_index :managers, :creator_id
    add_index :managers, :creator_type
  end
end
