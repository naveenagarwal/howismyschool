json.array!(@school_controllers) do |school_controller|
  json.extract! school_controller, :id
  json.url school_controller_url(school_controller, format: :json)
end
