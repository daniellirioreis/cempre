class ScheduleTeacher < ActiveRecord::Base
  belongs_to :teacher
  
  validates :time_start, :time_end, :day_week, presence: true
  
  scope :day_week, lambda { |day_week| where("day_week = ?", day_week)}  
  scope :time_start, lambda { |time_start| where("time_start >= ?", time_start)}
  scope :time_end, lambda { |time_start| where("time_end <= ?", time_end)}
  
end