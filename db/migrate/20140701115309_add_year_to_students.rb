class AddYearToStudents < ActiveRecord::Migration
  def change
    add_column :students, :year, :string
    add_index :students, :year
  end
end
