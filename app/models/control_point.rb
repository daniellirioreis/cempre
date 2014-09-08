class ControlPoint < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :calendar_day
  
  validates :teacher_id, :calendar_day_id, presence: true
  
  delegate :to_string, to: :calendar_day
  
  scope :calendar_day_id, lambda { |calendar_day_id| where("calendar_day_id = ? ", calendar_day_id) }

  scope :calendar_id_and_month, lambda { |id, month| where("calendar_days.calendar_id = ? AND EXTRACT(MONTH FROM calendar_days.day) = ?", id, month).joins(:calendar_day) }
  
  def working_minutes
    minutes_start = ConvertHoursForMinutes.convert(time_start.hour.to_i, time_start.min.to_i )
    if time_end.present?
      minutes_end = ConvertHoursForMinutes.convert(time_end.hour.to_i, time_end.min.to_i )      
    else
      minutes_end = 0
    end
    minutes_end - minutes_start
  end
end
