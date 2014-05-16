class Schedule < ActiveRecord::Base
  belongs_to :plan
  belongs_to :calendar_day

  validates :plan_id, :calendar_day_id, presence: true
  validates_presence_of :description, :on => :update

  delegate :to_string, to: :calendar_day

  scope :find_shedule, lambda { |day_week, course_id, calendar_day_id| where("plans.day_week = ? AND plans.course_id = ? AND schedules.calendar_day_id = ?", day_week, course_id, calendar_day_id).joins(:calendar_day, :plan) }

  def to_s
    to_string
  end

end