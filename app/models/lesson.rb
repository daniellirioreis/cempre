class Lesson < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :calendar_day
  has_many :faults, :dependent => :restrict_with_error
  has_many :exams, :dependent => :restrict_with_error

  delegate :to_string, to: :calendar_day
  delegate :time_start, :day_week, :course_id, to: :classroom
  validates :calendar_day_id, presence: true
  validates_uniqueness_of :calendar_day_id, :scope => :classroom_id

  def to_s
    calendar_day
  end

  scope :classroom_id, lambda { |id| where("classroom_id = ?", id) }

  scope :teacher_id, lambda { |id| where("classrooms.teacher_id = ?", id).joins(:classroom) }

  scope :by_month, lambda { |month| where("EXTRACT(MONTH FROM calendar_days.day) = #{month}").joins(:calendar_day) }


  def schedules
      calendar_day.schedules.find_shedule(day_week, course_id, calendar_day_id)
  end
end
