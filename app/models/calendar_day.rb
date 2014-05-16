class CalendarDay < ActiveRecord::Base
  belongs_to :calendar, :class_name => "Calendar", :foreign_key => "calendar_id"
  has_many :events
  has_many :schedules
  has_many :lessons

  validates_presence_of :calendar_id, :day
  validates_uniqueness_of :day, :scope => :calendar_id

  scope :search, lambda { |search| where(:day => "#{search}") }

  scope :by_month, lambda { |month| where(" EXTRACT(MONTH FROM day) = #{month}") }

  scope :by_year, lambda { |year| where(" EXTRACT(YEAR FROM day) = #{year}") }

  def to_s
    "#{day.day}/#{day.month}"
  end


  def schedules_of_day(day_week, course_id, calendar_day_id)
    schedules.find_shedule(day_week, course_id, calendar_day_id)
  end

  def to_string
    "#{day.day} de #{month_string}, #{weekday}"
  end

  def weekday
    w = nil
    if day.wday == 1
      w = "Segunda"
    end

    if day.wday == 2
       w = "Terça"
    end

    if day.wday == 3
      w = "Quarta"
    end

    if day.wday == 4
       w = "Quinta"
    end

    if day.wday == 5
      w = "Sexta"
    end

    if day.wday == 6
      w = "Sábado"
    end

    if day.wday == 0
      w = "Domingo"
    end
      w
  end

  def month_string
    m = nil
    if day.month == 1
      m = "Janeiro"
    end

    if day.month == 2
       m = "Fevereiro"
    end

    if day.month == 3
      m = "Março"
    end

    if day.month == 4
       m = "Abril"
    end

    if day.month == 5
      m = "Maio"
    end

    if day.month == 6
      m = "Junho"
    end

    if day.month == 7
      m = "Julho"
    end

    if day.month == 8
      m = "Agosto"
    end

    if day.month == 9
       m = "Setembro"
    end

    if day.month == 10
      m = "Outubro"
    end

    if day.month == 11
       m = "Novembro"
    end

    if day.month == 12
      m = "Dezembro"
    end
      m
  end
end