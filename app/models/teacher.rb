class Teacher < ActiveRecord::Base

  belongs_to :company
  has_many :classrooms
  has_many :schedule_teachers
  has_many :control_points
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
    "#{name}"
  end  
  
  def age
    if birth_date.present?
      Date.today.year - birth_date.year
    end
  end

end
