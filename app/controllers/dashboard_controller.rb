class DashboardController < ApplicationController
  before_action :change_companies, only: [:index]

  before_action :verify_current_calendar

  def index
    if current_user.student?
      @notes = current_company.notes.find_all_by_for_note(ForMessage::STUDENT)
    else
      @notes = current_company.notes
    end

    if current_calendar.present?
      if current_user.student.present?
        @events = current_calendar.events.student_id(current_user.student_id).no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
      else
        @events = current_calendar.events.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
      end
    else
      @events = []
    end

    if  can?(:read, 'birthdays_months')
      @birthdates = current_calendar.groups_active.bithday_day_and_month(Date.today.day, Date.today.month)
    end
  end

  private

  def change_companies
     redirect_to change_companies_manager_path(current_user) if current_calendar == nil && current_company == nil
  end

  def verify_current_calendar
    redirect_to change_companies_manager_path(current_user) if current_calendar == nil
  end

end
