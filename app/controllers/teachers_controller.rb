class TeachersController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    @teachers = current_company.teachers
  end

  def new
    @teacher = Teacher.new
  end

  def edit

  end

  def show
    @courses =  current_company.courses
    @classrooms =  @teacher.classrooms.open
  end

  def create
    @teacher = current_company.teachers.new(teacher_params)

    @teacher.save

    respond_with @teacher, :location => teachers_path
  end

  def update
    @teacher = current_company.teachers.find(params[:id])

    @teacher.update_attributes(teacher_params)

    respond_with @teacher, :location => teachers_path
  end


  private
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    def teacher_params
      params.require(:teacher).permit(:name,:street, :house_number, :complement, :zip_code, :neighborhood,
                                      :district, :city, :federal_unit, :email, :birth_date, :phone)
    end
end