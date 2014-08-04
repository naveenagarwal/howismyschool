class AddSubjectToMockTests < ActiveRecord::Migration
  def change
    add_reference :mock_tests, :subject, index: true
  end
end
