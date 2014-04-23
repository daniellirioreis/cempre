class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :daily, :generate_lessons, :for_month_print_daily]

  def index
    @classrooms = current_company.classrooms.open
  end

  def for_month_print_daily
    @lessons = @classroom.lessons
  end

  def schedules
    @head = Date.today
    @time_now = Time.now  - 3.time

    case Date.today.wday
      when 0
      when 1
        #segunda
        wday =  Day::MONDAY_AND_WEDNESDAY
      when 2
        wday =  Day::TUESDAY_AND_THURSDAY
      when 3
        wday =  Day::MONDAY_AND_WEDNESDAY
      when 4
        wday =  Day::TUESDAY_AND_THURSDAY
      when 5
      when 6
        wday =  Day::SATURDAY
    end

    @classrooms = current_company.classrooms.day_week(wday).open
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
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    def classroom_params
      params.require(:classroom).permit(:name, :course_id, :company_id, :day_week, :time_start, :time_end, :teacher_id, :capacity, :calendar_id)
    end
end
