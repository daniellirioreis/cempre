json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :color
  json.start event.calendar_day.day
  json.end event.calendar_day.day
  json.url calendar_day_url(event.calendar_day, event_id: event.id, format: :html)
end
