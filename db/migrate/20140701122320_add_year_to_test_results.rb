class AddYearToTestResults < ActiveRecord::Migration
  def change
    add_column :test_results, :year, :string
    add_index :test_results, :year
  end
end
