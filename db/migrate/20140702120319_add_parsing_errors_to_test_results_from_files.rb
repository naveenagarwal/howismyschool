class AddParsingErrorsToTestResultsFromFiles < ActiveRecord::Migration
  def change
    add_column :test_results_from_files, :parsing_errors, :text
  end
end
