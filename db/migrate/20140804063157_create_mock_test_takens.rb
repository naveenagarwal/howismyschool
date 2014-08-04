class CreateMockTestTakens < ActiveRecord::Migration
  def change
    create_table :mock_test_takens do |t|
      t.references :mock_test, index: true
      t.references :student, index: true
      t.references :ques_and_ans, index: true
      t.json :answer_given, default: {}

      t.timestamps
    end
  end
end
