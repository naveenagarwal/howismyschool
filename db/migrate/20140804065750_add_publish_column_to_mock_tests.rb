class AddPublishColumnToMockTests < ActiveRecord::Migration
  def change
    add_column :mock_tests, :publish, :boolean
  end
end
