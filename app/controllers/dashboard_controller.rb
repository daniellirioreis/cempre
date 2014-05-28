class DashboardController < ApplicationController
  before_action :change_companies, only: [:index]

  before_action :verify_current_calendar

  def index
    if current_user.student?
      @notes = current_user.student.company_active.notes.find_all_by_for_note(ForMessage::STUDENT)
    else
      @notes = current_company.notes
    end

      if current_user.student.present?
        @events = Event.student_id(current_user.student_id).no_finalized
      else
        if current_calendar.present?
          @monitorings = current_calendar.events.monitoring.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
          @days_trial = current_calendar.events.day_trial.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
          @importants = current_calendar.events.important.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
        else
          @monitorings = []
          @days_trial = []
          @importants = []
        end
      end

    if  can?(:read, 'birthdays_months')
      unless current_user.student?
        @birthdates = current_calendar.groups_active.bithday_day_and_month(Date.today.day, Date.today.month)
       else
         @birthdates = []
       end
    end
  end

  private

  def change_companies
    if current_calendar == nil && current_company == nil
      unless current_user.student?
        redirect_to change_companies_manager_path(current_user)
      end
    end
  end

  def verify_current_calendar
    if current_calendar == nil
      unless current_user.student?
        redirect_to change_companies_manager_path(current_user)
      end
    end
  end

end
