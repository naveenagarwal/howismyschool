json.array!(@comments) do |comment|
  json.extract! comment, :id, :description, :comentator_id, :comment_for_id
  json.url comment_url(comment, format: :json)
end
