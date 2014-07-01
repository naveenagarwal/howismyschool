json.array!(@uploaded_test_results) do |uploaded_test_result|
  json.extract! uploaded_test_result, :id
  json.url uploaded_test_result_url(uploaded_test_result, format: :json)
end
