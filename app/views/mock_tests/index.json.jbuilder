json.array!(@mock_tests) do |mock_test|
  json.extract! mock_test, :id, :school_branch_id, :creator_id, :creator_type, :name, :class_room_id
  json.url mock_test_url(mock_test, format: :json)
end
