class EventMailer < ActionMailer::Base
  def information_for_event(event)
    @event = event
    mail :to => "#{event.teacher.email}", :from => "#{event.calendar_day.calendar.company.email}", :subject => "Monitoria"
  end
end
