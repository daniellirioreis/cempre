class ClassroomsController < ApplicationController

  before_filter :authorize_controller!


  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :daily, :generate_lessons, :for_month_print_daily, :throw_faults]

  before_action :verify_current_calendar

  def index
    @classrooms = current_calendar.classrooms
  end

  def report_schedules
    classrooms = current_calendar.classrooms
    @classrooms_monday_wednesday = classrooms.day_week3(Day::MONDAY, Day::MONDAY_AND_WEDNESDAY, Day::WEDNESDAY)
    @classrooms_tuesday_thursday = classrooms.day_week(Day::THURSDAY, Day::TUESDAY_AND_THURSDAY)
    @classrooms_saturday = classrooms.day_week(Day::SATURDAY, Day::SATURDAY)    
  end

  def throw_faults
    if params[:month].blank?
      params[:month] = Date.today.month
    end
    @lessons = @classroom.lessons.by_month(params[:month])
  end

  def schedules_for_week_day
    wday = params[:week_day]
    wday1 = params[:week_day]
    @classrooms = current_calendar.classrooms.day_week(wday, wday1).open
  end

  def show
    respond_to do |format|
         format.html # index.html.erb
         format.json { render json: @classroom }
         format.js #index.js.erb
       end
  end

  def for_month_print_daily
    @lessons = @classroom.lessons
  end

  def schedules
    @head = Date.today
    @calendar_day = CalendarDay.company_id(current_company.id)
    @calendar_day = @calendar_day.find_by_day(@head)
    
    @time_now = Time.now #- 3.hours

    if @calendar_day.present?
      @lessons =  @calendar_day.lessons         
    else
      @lessons = []
    end

  end

  def new
    @classroom = Classroom.new
  end

  def daily
    @lessons = @classroom.lessons.by_month(params[:month])
  end

  def generate_lessons
    @classroom.build_lessons

    flash[:info] = "Aulas geradas com sucesso !"

    redirect_to @classroom
  end

  def edit
  end

  def create
    @classroom = current_company.classrooms.new(classroom_params)

    @classroom.save

    respond_with @classroom, :location => classrooms_path
  end

  def update
    @classroom = current_company.classrooms.find(params[:id])

    @classroom.update_attributes(classroom_params)

    respond_with @classroom, :location => classrooms_path
  end

  private

    def verify_current_calendar
      redirect_to change_companies_manager_path(current_user) if current_calendar == nil
    end

    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    def classroom_params
      params.require(:classroom).permit(:name, :course_id, :company_id, :day_week, :time_start, :time_end, :teacher_id, :capacity, :calendar_id, :open_for_enrollments, :closed)
    end
end
