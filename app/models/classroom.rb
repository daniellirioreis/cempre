class Classroom < ActiveRecord::Base
  belongs_to :course
  belongs_to :company
  belongs_to :teacher
  belongs_to :calendar
  has_many :groups
  has_many :lessons

  has_enumeration_for :day_week, :with => Day, :create_helpers => true, :create_scopes => true

  validates :course_id, :teacher_id, :calendar_id, :capacity, presence: true

  scope :open, -> {where(closed: false )}

  scope :closed, -> {where(closed: true )}

  delegate :sequence, :type_course, to: :course

  scope :open_for_enrollments, -> {where(open_for_enrollments: true )}

  scope :day_week, lambda { |day_week, day_week1| where("day_week = ? OR day_week = ?", day_week, day_week1) }
  
  scope :day_week3, lambda { |day_week, day_week1, day_week2| where("day_week = ? OR day_week = ? OR day_week = ?", day_week, day_week1, day_week2) }
  
  

  scope :calendar_id, lambda { |calendar_id| where("calendar_id = ? ", calendar_id) }

  scope :teacher_id, lambda { |id| where("teacher_id = ? ", id) }
  
  scope :course_id, lambda { |course_id| where("course_id = ? ", course_id) }
  

  scope :sequence_and_type_course, lambda { |sequence, type_course| where("courses.sequence = ? and courses.type_course = ? ", sequence, type_course).joins(:course) }

  scope :sorted, -> { order(:day_week, :time_start) }
    

  def working_minutes
    minutes_start = ConvertHoursForMinutes.convert(time_start.hour.to_i, time_start.min.to_i )
    if time_end.present?
      minutes_end = ConvertHoursForMinutes.convert(time_end.hour.to_i, time_end.min.to_i )      
    else
      minutes_end = 0
    end
    minutes_end - minutes_start
  end


  def to_s
    name
  end

  def count_students
    groups.active.count
  end

  def vacancy
    capacity - count_students
  end

  def remaining_vacancies
   capacity - count_students
  end

  def groups_re_enrollment_failed
    groups.re_enrollment.failed.count
  end

  def groups_re_enrollment_approved
    groups.re_enrollment.approved.count
  end


  def minutes_of_class
    hours = time_end.hour - time_start.hour
    minutes = (time_end.min - time_start.min) * -1
    minutes_for_hours =  hours * 60
    minutes_for_hours
  end

  def minutos_restantes(time_now)
    hours = time_end.hour - time_now.hour
    minutes = (time_end.min - time_now.min)
    minutes_for_hours =  hours * 60
    minutes_for_hours = minutes_for_hours + minutes
  end


  def build_lessons
    unless calendar_id == nil
      calendar.days.each do |day|
        if monday_and_wednesday?
          if day.day.wday == 1
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
          if day.day.wday == 3
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end
        if tuesday_and_thursday?
          if day.day.wday == 2
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
          if day.day.wday == 4
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end
        if saturday?
          if day.day.wday == 6
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end
        if wednesday?
          if day.day.wday == 3
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end

        if monday?
          if day.day.wday == 1
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end

        if thursday?
          if day.day.wday == 4
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end
        
        if tuesday?
          if day.day.wday == 2
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end
        if monday_and_tuesday?
          if day.day.wday == 2
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
          
          if day.day.wday == 1
            lesson = Lesson.new(:calendar_day_id => day.id, :classroom_id => self.id)
            if lesson.save
            end
          end
        end
      end
    end
  end
end