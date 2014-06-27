json.array!(@students) do |student|
  json.extract! student, :id, :name, :roll_number, :class_room, :creator_id, :creator_type
  json.url student_url(student, format: :json)
end
