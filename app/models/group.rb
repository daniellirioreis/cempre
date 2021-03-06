class Group < ActiveRecord::Base
  belongs_to :student
  belongs_to :classroom
  belongs_to :new_classroom, :class_name => "Classroom", :foreign_key => "new_classroom_id"
  has_many :faults, :dependent => :restrict_with_error
  has_many :exams, :dependent => :restrict_with_error
  has_one :questionnaire
  delegate :course, :company, :calendar, to: :classroom

  delegate :day_of_birth, :name, :birth_date, :neighborhood, to: :student

  has_enumeration_for :status, :with => StatusGroup, :create_helpers => true, :create_scopes => true

  validates :student_id, :status, presence: true

  validate :validate_group

  scope :status, lambda { |status| where("groups.status = ?", status) }
  
  scope :different_id, lambda { |id| where("groups.id = ?", id) }

  scope :less_id, lambda { |id| where("groups.id < ?", id) }
  

  scope :active, -> {where("status = ?", StatusGroup::ACTIVE)}
  
  scope :not_have_book, -> {where("have_book = ?", false)}
  

  scope :re_enrollment, -> {where("re_enrollment = ?", true)}
  scope :no_enrollment, ->  {where("re_enrollment != ?", true)}
  

  scope :second_change_exam, -> {where("second_change_exam = ?", true)}

  scope :approved, -> {where("status = ?", StatusGroup::APPROVED)}

  scope :folded, -> {where("status = ?", StatusGroup::FOLDED)}
  scope :locked, -> {where("status = ?", StatusGroup::LOCKED)}
  
  

  scope :locked_or_folded, -> {where("status = ? OR status = ?", StatusGroup::LOCKED, StatusGroup::FOLDED)}


  scope :active_or_approved_or_failed, -> {where("status = ? OR status = ? OR status = ?", StatusGroup::ACTIVE, StatusGroup::APPROVED, StatusGroup::FAILED )}


  scope :failed, -> {where("status = ?", StatusGroup::FAILED)}

  scope :no_transfer, -> {where("status != ?", StatusGroup::TRANSFER)}

  scope :sorted, -> { order("groups.status, students.name").joins(:student) }
  scope :sorted_neighborhood, -> { order("students.neighborhood").joins(:student) }
  

  scope :sorted_week_and_time, -> { order("classrooms.day_week, classrooms.time_start").joins(:classroom) }


  scope :bithday, lambda { |month| where(" EXTRACT(MONTH FROM birth_date) = #{month}").joins(:student) }

  scope :bithday_day_and_month, lambda { |day, month| where(" EXTRACT(DAY FROM birth_date) = #{day} AND EXTRACT(MONTH FROM birth_date) = #{month}").joins(:student)}


  scope :classroom_id, lambda { |id| where("classroom_id = ?", id) }

  scope :type_course, lambda { |type| where("courses.type_course = ?", type).joins(:classroom => :course) }
  
  
  scope :types_courses, lambda { |type1, type2| where("courses.type_course = ? OR courses.type_course = ? ", type1, type2).joins(:classroom => :course) }
  

  scope :student_id, lambda { |id| where("student_id = ?", id) }

  scope :calendar_id, lambda { |id| where("classrooms.calendar_id = ?", id).joins(:classroom) }
  
  scope :course_id, lambda { |id| where("classrooms.course_id = ?", id)}
  

  scope :join_classroom_find_course_id, lambda { |id| where("classrooms.course_id = ?", id).joins(:classroom) }

  scope :different_group_id, lambda { |id| where("groups.id  <> ?", id)}
  
  

  scope :down_average, lambda { |down_average| where("exams.value <?", down_average).joins(:exams) }
  
  scope :teacher_id, lambda { |id| where("classrooms.teacher_id = ?", id).joins(:classroom) }
  
  scope :not_join_classroom_teacher_id, lambda { |id| where("classrooms.teacher_id = ?", id) }
  
  
  scope :type_exam, lambda { |type_exam| where("exams.type_exam = ?", type_exam)}
  
  
  scope :up_average, lambda { |down_average| where("exams.value >=?", down_average).joins(:exams) }
  

  scope :type_exam, lambda { |type_exam| where("exams.type_exam = ?", type_exam) }

  scope :open_for_enrollments, -> {where("classrooms.open_for_enrollments = true ").joins(:classroom)}

  scope :closed_for_enrollments, -> {where("classrooms.open_for_enrollments = false ").joins(:classroom)}
  

  scope :open_for_enrollments_english, -> {where("classrooms.open_for_enrollments = true AND courses.type_exam #{TypeExam::ENGLISH}").joins(:classroom => :course)}

  scope :by_month, lambda { |month| where(" EXTRACT(MONTH FROM groups.created_at) = #{month}") }
  
  scope :not_have_neighborhood, lambda { |type1, type2| where("students.neighborhood = ? or students.neighborhood = ?", type1, type2).joins(:student) }
  

  after_save :create_transfer
  
  def new_exam(type_event)
    lesson_id = nil
    if type_event == 'Midterm'
      events = Event.calendar_id(classroom.calendar_id).midterm
      if events.any?
        event = nil
        events.each do |e|
           
           if classroom.monday_and_wednesday? 
             if e.wday  == 1  || e.wday == 3
               event = e 
             end  
           end 
           
           if classroom.tuesday_and_thursday? 
             if e.wday  == 2  || e.wday == 4
               event = e 
             end  
           end 

           if classroom.saturday?
             if e.wday  == 6
               event = e 
             end  
           end 

           if classroom.wednesday?
             if e.wday  == 3
               event = e 
             end  
           end 

           if classroom.monday?
             if e.wday  == 1
               event = e 
             end  
           end 

           if classroom.thursday?
             if e.wday  == 4
               event = e 
             end  
           end 

           if classroom.tuesday?
             if e.wday  == 2
               event = e 
             end  
           end 
           
           if classroom.monday_and_tuesday?
             if e.wday  == 2 || e.wday == 1
               event = e 
             end  
           end 
        end
        if event.present?
          lessons = event.calendar_day.lessons
          if lessons.any?
            lesson = lessons.find_by_classroom_id(classroom_id)
            if lesson.present?
              lesson_id = lesson.id
            end  
          end
        end
      end  
    end
    
    if type_event == 'Speech'
      events = Event.calendar_id(classroom.calendar_id).speech
      if events.any?
        event = nil
        events.each do |e|
           
           if classroom.monday_and_wednesday? 
             if e.wday  == 1  || e.wday == 3
               event = e 
             end  
           end 
           
           if classroom.tuesday_and_thursday? 
             if e.wday  == 2  || e.wday == 4
               event = e 
             end  
           end 

           if classroom.saturday?
             if e.wday  == 6
               event = e 
             end  
           end 

           if classroom.wednesday?
             if e.wday  == 3
               event = e 
             end  
           end 

           if classroom.monday?
             if e.wday  == 1
               event = e 
             end  
           end 

           if classroom.thursday?
             if e.wday  == 4
               event = e 
             end  
           end 

           if classroom.tuesday?
             if e.wday  == 2
               event = e 
             end  
           end 
           
           if classroom.monday_and_tuesday?
             if e.wday  == 2 || e.wday == 1
               event = e 
             end  
           end 
        end
        if event.present?
          lessons = event.calendar_day.lessons
          if lessons.any?
            lesson = lessons.find_by_classroom_id(classroom_id)
            if lesson.present?
              lesson_id = lesson.id
            end  
          end
        end
      end  
      
    end
    if type_event == 'Final'
      events = Event.calendar_id(classroom.calendar_id).final
      if events.any?
        event = nil
        events.each do |e|
           
           if classroom.monday_and_wednesday? 
             if e.wday  == 1  || e.wday == 3
               event = e 
             end  
           end 
           
           if classroom.tuesday_and_thursday? 
             if e.wday  == 2  || e.wday == 4
               event = e 
             end  
           end 

           if classroom.saturday?
             if e.wday  == 6
               event = e 
             end  
           end 

           if classroom.wednesday?
             if e.wday  == 3
               event = e 
             end  
           end 

           if classroom.monday?
             if e.wday  == 1
               event = e 
             end  
           end 

           if classroom.thursday?
             if e.wday  == 4
               event = e 
             end  
           end 

           if classroom.tuesday?
             if e.wday  == 2
               event = e 
             end  
           end 
           
           if classroom.monday_and_tuesday?
             if e.wday  == 2 || e.wday == 1
               event = e 
             end  
           end 
        end
        if event.present?
          lessons = event.calendar_day.lessons
          if lessons.any?
            lesson = lessons.find_by_classroom_id(classroom_id)
            if lesson.present?
              lesson_id = lesson.id
            end  
          end
        end
      end  
      
    end
    
    if type_event == 'Oral'
      events = Event.calendar_id(classroom.calendar_id).oral
      if events.any?
        event = nil
        events.each do |e|
           
           if classroom.monday_and_wednesday? 
             if e.wday  == 1  || e.wday == 3
               event = e 
             end  
           end 
           
           if classroom.tuesday_and_thursday? 
             if e.wday  == 2  || e.wday == 4
               event = e 
             end  
           end 

           if classroom.saturday?
             if e.wday  == 6
               event = e 
             end  
           end 

           if classroom.wednesday?
             if e.wday  == 3
               event = e 
             end  
           end 

           if classroom.monday?
             if e.wday  == 1
               event = e 
             end  
           end 

           if classroom.thursday?
             if e.wday  == 4
               event = e 
             end  
           end 

           if classroom.tuesday?
             if e.wday  == 2
               event = e 
             end  
           end 
           
           if classroom.monday_and_tuesday?
             if e.wday  == 2 || e.wday == 1
               event = e 
             end  
           end 
        end
        if event.present?
          lessons = event.calendar_day.lessons
          if lessons.any?
            lesson = lessons.find_by_classroom_id(classroom_id)
            if lesson.present?
              lesson_id = lesson.id
            end  
          end
        end
      end  
      
    end
    
    
    Exam.new(group_id: id, value: 0, lesson_id: lesson_id)
  end

  def to_s
    student
  end

  def value_tatal
    (exams.sum(:value) / exams.count).round(2)
  end
  
  def fault_title(lesson_id)
    f = faults.find_by_group_id_and_lesson_id(id, lesson_id)  
    if f.present?
       if f.justification != 0 
        "FJ"
       else
         'F'
       end
    else
      "P"
    end  
  end
  
  
  def frequency
    total_lessons = classroom.lessons.count
    total_faults =  student.faults_for_calendar(classroom.calendar_id, classroom.course.type_course).count
    unless total_faults == 0 && total_lessons == 0
      m = total_faults * 100
      mm = m / total_lessons
      100 - mm      
    else
      0
    end
  end
  
  def repeat
   calendar_previus =  Calendar.next_calendar_id(classroom.calendar_id).first
   if calendar_previus.present? 
     student.groups.calendar_id(calendar_previus.id).course_id(classroom.course.id).status(StatusGroup::FAILED).any?     
   else
     false
   end   
  end

  private

  def validate_group

    unless self.new_record?
      if status == StatusGroup::LOCKED || status == StatusGroup::FOLDED
        if justification.blank?
          errors.add(:justification, :blank )
        end
      end

      if status == StatusGroup::TRANSFER        
        if (new_classroom.groups.active.count + 1) > new_classroom.capacity
          errors.add(:student_id, "não pode ser enturmamado, turma não possui mais vaga") 
        end
      end
      
    else
      errors.add(:student_id, "não pode ser enturmamado, turma não possui mais vaga") if (classroom.groups.active.count + 1) > classroom.capacity
    end

  end

  def create_transfer
      if transfer?
        group = Group.new(:student_id => student_id, :classroom_id => new_classroom_id, :status => 0)
        group.save!
      end
  end
end
