json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :title, :creator_id, :creator_type, :school_branch_id, :event_for, :start_time, :end_time
  json.url schedule_url(schedule, format: :json)
end
