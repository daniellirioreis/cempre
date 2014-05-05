class DashboardController < ApplicationController
  def index
    if current_user.student?
      @notes = current_company.notes.find_all_by_for_note(ForMessage::STUDENT)
    else
      @notes = current_company.notes
    end

    if current_calendar.present?
      @events = current_calendar.events.day_start(Date.today).day_end(Date.today + 3.day).sorted
    else
      @events = []
    end
  end
end
