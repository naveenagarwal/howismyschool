class AddDetailsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :mother_name, :string
    add_column :students, :father_name, :string
    add_column :students, :address, :string
    add_column :students, :previous_school, :string
    add_column :students, :father_phone, :string
    add_column :students, :mother_phone, :string
    add_column :students, :email, :string
    add_column :students, :other_info, :text
  end
end
