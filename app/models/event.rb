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

  def to_s
    if monitoring?
      "#{description} - #{student} - #{teacher}"
    else
       "#{description}"
    end
  end
end
