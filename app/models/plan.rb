class Plan < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :course
  has_many :schedules, dependent: :delete_all

  has_enumeration_for :day_week, :with => Day, :create_helpers => true, :create_scopes => true


  delegate :days, to: :calendar

  validates :calendar_id, :course_id, :day_week,  presence: true
  validates :course_id, uniqueness: { scope: [:calendar_id, :day_week] }

  after_save :create_schedules


  def to_s
    "#{course.name} - #{day_week_humanize}"
  end

  private

  def create_schedules
    if  new_record? 
    
      
      if calendar.present?
        days.each do |day|
          case day_week
            when Day::MONDAY_AND_WEDNESDAY
              if day.day.wday == 1
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end

              if day.day.wday == 3
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end
            when Day::TUESDAY_AND_THURSDAY
              if day.day.wday == 2
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end
              if day.day.wday == 4
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end
            when Day::SATURDAY
              if day.day.wday == 6
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end
            when Day::WEDNESDAY
              if day.day.wday == 3
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end
            when Day::MONDAY
              if day.day.wday == 1
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end
            when Day::THURSDAY
              if day.day.wday == 4
                schedule = Schedule.new(:calendar_day_id => day.id, :plan_id => id)
                if schedule.save
                end
              end            
          end
        end
      end
    end
  end
end
