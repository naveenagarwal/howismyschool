class AddFromFileToTestResults < ActiveRecord::Migration
  def change
    add_reference :test_results, :test_results_from_file, index: true
  end
end
