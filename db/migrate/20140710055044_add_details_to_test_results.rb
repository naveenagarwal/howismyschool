class AddDetailsToTestResults < ActiveRecord::Migration
  def change
    add_column :test_results, :class_room_name, :string
    add_column :test_results, :class_test_name, :string
    add_column :test_results, :student_name, :string
    add_column :test_results, :subject_name, :string
  end
end
