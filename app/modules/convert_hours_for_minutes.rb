class ConvertHoursForMinutes
  def self.convert(hours, minutes)
    minutes_for_hours = 0
    minutes_for_hours = hours * 60
    minutes_for_hours = minutes_for_hours + minutes
  end
  
  def self.convert_hours(minutes)
    hours_and_minutes = minutes.divmod(60)    
    h = hours_and_minutes.first
    m = hours_and_minutes.last
    "#{h} horas e #{m} minutos"
  end
  
end