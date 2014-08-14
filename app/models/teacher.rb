class Teacher < ActiveRecord::Base

  belongs_to :company
  has_many :classrooms
  has_many :schedule_teachers
  accepts_nested_attributes_for :schedule_teachers, :reject_if => :all_blank, :allow_destroy => true
  
  scope :sorted, -> { order(:name) }
  scope :monitor, -> {where(monitor: true )}
  

  def to_s
    name
  end

  def lessons
     Lesson.teacher_id(id)
  end

  def to_s_monitor
    "#{name} #{string_schedule_teachers}"
  end
  
  def string_schedule_teachers
    string = ""
    schedule_teachers.each do |st|
      string = string + " " + "| #{st.day_week_humanize} #{st.time_start.try(:strftime, '%H:%M')} às #{st.time_end.try(:strftime, '%H:%M')} |"
    end
    string
  end
  
  def age
    if birth_date.present?
      Date.today.year - birth_date.year
    end
  end

end
