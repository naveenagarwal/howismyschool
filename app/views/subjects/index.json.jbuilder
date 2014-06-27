json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :school_branch_id, :creator_id, :creator_type
  json.url subject_url(subject, format: :json)
end
