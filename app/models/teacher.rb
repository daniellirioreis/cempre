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

  def working_minutes(calendar_id)
    m = 0
    classrooms.calendar_id(calendar_id).each do |c|
      m =  m +  c.working_minutes
    end
    m
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
  
  def groups_approved(calendar_id)
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(calendar_id).not_join_classroom_teacher_id(id).approved
  end
  
  def groups_failed(calendar_id)
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(calendar_id).not_join_classroom_teacher_id(id).failed
  end
  
  def groups_folded(calendar_id)
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(calendar_id).not_join_classroom_teacher_id(id).folded
  end

  def groups_locked(calendar_id)
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(calendar_id).not_join_classroom_teacher_id(id).locked
  end
  
  def groups_transfer(calendar_id)
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(calendar_id).not_join_classroom_teacher_id(id).transfer
  end
  
    
  def groups(calendar_id)
    Group.select(:student_id).distinct.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(calendar_id).not_join_classroom_teacher_id(id)
  end
  
  

end
