class Calendar < ActiveRecord::Base
  belongs_to :company
  has_many :days, :class_name => "CalendarDay", :foreign_key => "calendar_id"
  has_many :classrooms, :class_name => "Classroom", :foreign_key => "calendar_id"
  validates :name, :average, presence: true

  after_save :build_days

  scope :open, -> {where(closed: false )}


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
    Group.calendar_id(id).active
  end

  def groups_locked_or_folded
    Group.calendar_id(id).no_transfer.locked_or_folded
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