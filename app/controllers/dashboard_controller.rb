class DashboardController < ApplicationController
  before_action :change_companies, only: [:index]

  before_action :verify_current_calendar

  def index
    @monitorings = []
    @midterms = []    
    @days_trial = []
    @importants = []
    @birthdates = []
    @notes = []
    @orals = []
    @finals = []
    
    @students_block_schedule_different = []
    @rents_books = []
    
    if current_user.adm 
      @students_block_schedule_different = current_company.students.block_schedule_different
    end
    
    if current_user.student?
      @company_active = current_user.student.company_active
      if @company_active.present?
        @notes = current_user.student.company_active.notes.sorted.for_student
      end
    else
      @notes = current_company.notes.sorted
    end

      if current_user.student.present?
        @events = Event.student_id(current_user.student_id).no_finalized
        @lessons_for_today = current_user.student.lessons_for_today(Date.today)
      else
        if current_calendar.present?
          @monitorings = current_calendar.events.monitoring.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
          @days_trial = current_calendar.events.day_trial.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted
          @importants = current_calendar.events.important.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted          
          
          @midterms = current_calendar.events.midterm.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted          
          @finals = current_calendar.events.final.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted          
          @orals = current_calendar.events.oral.no_finalized.day_start(Date.today).day_end(Date.today + 3.day).sorted          
          
          @rents_books = Rent.company_id(current_company.id).not_returned
          
        end
      end

    if  can?(:read, 'birthdays_months')
      unless current_user.student?
        @birthdates = current_calendar.groups_active.bithday_day_and_month(Date.today.day, Date.today.month)
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
