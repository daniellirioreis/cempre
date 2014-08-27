json.array!(@calendar_days) do |cd|
  json.extract! cd, :id, :title,
  json.start cd.day
  json.end  cd.day
  json.url calendar_day_url(cd, format: :html)
end
