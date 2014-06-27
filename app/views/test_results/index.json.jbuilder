json.array!(@test_results) do |test_result|
  json.extract! test_result, :id, :percentage, :grade, :outcome, :remarks, :subject_id, :student_id, :class_test_id, :school_branch_id, :class_room, :creator_id, :creator_type
  json.url test_result_url(test_result, format: :json)
end
