json.array!(@class_tests) do |class_test|
  json.extract! class_test, :id, :name, :school_id, :school_branch_id, :creator_id, :creator_type
  json.url class_test_url(class_test, format: :json)
end
