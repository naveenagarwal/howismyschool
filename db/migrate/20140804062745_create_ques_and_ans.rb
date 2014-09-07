class CreateQuesAndAns < ActiveRecord::Migration
  def change
    # execute "CREATE EXTENSION hstore"
    create_table :ques_and_ans do |t|
      t.text :question
      t.integer :answer_type
      t.text :answer_choices, default: {}
      t.text :right_answer, default: {}
      t.references :mock_test, index: true
      t.references :creator, polymorphic: true, index: true

      t.timestamps
    end
  end
end
