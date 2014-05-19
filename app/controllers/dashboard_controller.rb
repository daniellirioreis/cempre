class DashboardController < ApplicationController
  def index
    if current_user.student?
      @notes = current_company.notes.find_all_by_for_note(ForMessage::STUDENT)
    else
      @notes = current_company.notes
    end

    if current_calendar.present?
      @events = current_calendar.events.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
    else
      @events = []
    end

    if  can?(:read, 'birthdays_months')
      @birthdates = current_calendar.groups_active.bithday_day_and_month(Date.today.day, Date.today.month)
    end

  end
end
