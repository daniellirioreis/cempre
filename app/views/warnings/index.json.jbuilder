json.array!(@warnings) do |warning|
  json.extract! warning, :id, :student_id, :description
  json.url warning_url(warning, format: :json)
end
