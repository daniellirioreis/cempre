class Calendar < ActiveRecord::Base
  belongs_to :company
  belongs_to :next_calendar, :class_name => "Calendar", :foreign_key => "next_calendar_id"
  has_many :days, :class_name => "CalendarDay", :foreign_key => "calendar_id"
  has_many :classrooms
  has_many :plans

  validates :name, :vacancy, :average, presence: true

  after_save :build_days

  scope :open, -> {where(closed: false )}

  scope :not_equal_id, lambda { |id| where("id <> ?", id) }
  
  scope :next_calendar_id, lambda { |id| where("next_calendar_id = ?", id) }
  
  scope :sorted, -> { order("calendars.date_start") }


  def to_s
    "#{name} - #{date_start.day}/#{date_start.month}/#{date_start.year} à #{date_end.day}/#{date_end.month}/#{date_end.year}"
  end

  def events
    Event.calendar_id(id)
  end


  def groups_second_change_exam
    Group.calendar_id(id).active.second_change_exam
  end

  def groups_active
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(id).active
  end
  
  def groups_approved
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(id).approved
  end
  
  def groups_failed
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(id).failed
  end

  def groups_folded
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(id).folded
  end

  def groups_locked
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(id).locked
  end
  
  
  def groups
    Group.types_courses(TypeCourse::ENGLISH, TypeCourse::SPANISH).calendar_id(id)
  end
  

  def groups_re_enrollments
    Group.calendar_id(id).active_or_approved_or_failed.re_enrollment
  end

  def groups_locked_or_folded
    Group.calendar_id(id).no_transfer.locked_or_folded
  end

  def vacancy
    classrooms.open_for_enrollments.sum(:capacity)
  end

  def remaining_vacancies
    vacancy - groups_active.open_for_enrollments.count
  end

  def months
     ms = []
     (date_start.month.to_i..date_end.month).each do  |m|
       ms << m
     end
     ms
  end

  protected

  def build_days
    (date_start..date_end).each do |day|
      calendar_day = CalendarDay.new(:day => day, :calendar_id => self.id)
      if calendar_day.save
      end
    end
  end
end