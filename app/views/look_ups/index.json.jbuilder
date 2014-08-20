json.array!(@look_ups) do |look_up|
  json.extract! look_up, :id
  json.url look_up_url(look_up, format: :json)
end
