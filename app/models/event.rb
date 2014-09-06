class Event < ActiveRecord::Base
  belongs_to :calendar_day
  belongs_to :student
  belongs_to :teacher

  has_enumeration_for :type_event, :create_helpers => true, :create_scopes => true


  scope :calendar_id, lambda { |id| where("calendar_days.calendar_id = ?", id).joins(:calendar_day) }

  scope :student_id, lambda { |id| where("events.student_id = ?", id)}


  scope :day_start, lambda { |date| where("calendar_days.day >= ?", date).joins(:calendar_day) }
  scope :day_end, lambda { |date| where("calendar_days.day <= ?", date).joins(:calendar_day) }
  scope :sorted, -> { order("calendar_days.day") }

  scope :no_finalized, -> {where("closed = ?", false)}

  scope :monitoring, -> {where("type_event = ?", TypeEvent::MONITORING )}

  scope :day_trial, -> {where("type_event = ?", TypeEvent::DAY_TRIAL )}
  scope :important, -> {where("type_event = ?", TypeEvent::IMPORTANT )}



  scope :sorted_time_start, -> { order(:time_start) }


  validates :description, :type_event, presence: true

  validates_presence_of :teacher_id, :if => :monitoring?
  validates_presence_of :student_id, :if => :monitoring?
  # validate :monitoring
  
  def to_s
    if monitoring?
      "#{description} - #{student} - #{teacher}(#{type_event_humanize.upcase})"
    else
       "#{description}"
    end
  end
  
  def monitoring
    if teacher.present? 
      unless teacher.schedule_teachers.empty?
        schedule_teachers = teacher.schedule_teachers.day_week(calendar_day.day.wday)      
        if  schedule_teachers.any?
           hora_evento_final      =  ConvertHoursForMinutes.convert(time_end.hour, time_end.min) 
           hora_evento_inicial    =  ConvertHoursForMinutes.convert(time_start.hour, time_start.min) 
           
           s = []
           
           schedule_teachers.each do |st|
             hora_monitoria_inicial =  ConvertHoursForMinutes.convert(schedule_teachers.first.time_start.hour, schedule_teachers.first.time_start.min) 
             hora_monitoria_final   =  ConvertHoursForMinutes.convert(schedule_teachers.first.time_end.hour, schedule_teachers.first.time_end.min)              
             if hora_evento_inicial >= hora_monitoria_inicial
               if hora_evento_final <= hora_monitoria_final
                 s << st                             
               end
             end             
           end                        
            if s.empty? 
              errors.add(:teacher_id, "não possui horário definido para dia selecionado.")                         
            end
            
        else
          errors.add(:teacher_id, "não possui horário de monitoria definido.")           
        end
      else
        errors.add(:teacher_id, "não possui horário de monitoria definido.") 
      end      
    end
  end

end
