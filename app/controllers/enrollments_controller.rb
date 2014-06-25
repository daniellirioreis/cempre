class EnrollmentsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  before_action :check_capacity, only: [:create]


  def index
    @classrooms = current_calendar.classrooms.open_for_enrollments.open
    @quant_classrooms = @classrooms.open_for_enrollments.count
    @vacancy = current_calendar.vacancy
    @groups_active = current_calendar.groups_active.open_for_enrollments.count
    @remaining_vacancies = current_calendar.remaining_vacancies
  end

  def list_classrooms_to_re_enrollments
    @classroom_old = Classroom.find(params[:classroom_id])
    @groups_approved = @classroom_old.groups.sorted.approved
  end

  def new
    @enrollment = Enrollment.new(classroom_id: params[:classroom_id])
  end

  def create
    @enrollment = current_company.enrollments.new(enrollment_params)

    @enrollment.save

    respond_with @enrollment, :location => enrollments_path
  end

  def update
    @enrollment = current_company.enrollments.find(params[:id])

    @enrollment.update_attributes(enrollmentt_params)

    respond_with @enrollment, :location => enrollments_path

  end


  private
    def check_capacity
        classroom = Classroom.find(params[:classroom_id])
        if classroom.vacancy == 0
          flash[:alert] = "Inscrição não pode ser concluida! Vaga para #{classroom} no horário de
          #{classroom.time_start.try(:strftime, '%H:%M')} às #{classroom.time_end.try(:strftime, '%H:%M')} - #{classroom.day_week_humanize}
          foi esgotada."
          redirect_to enrollments_path
        end
    end

    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:name,:street, :house_number, :complement, :zip_code, :neighborhood,
                                      :district, :city, :federal_unit, :email, :birth_date, :phone, :classroom_id)
    end

end