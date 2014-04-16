class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :my_data, :my_exams, :declaration_of_studying]

  def index
    @students = current_company.students.sorted
  end

  def declaration_of_studying
    @group = @student.groups.active.first

    render :declaration_of_studying, :layout => false

  end

  def show
    @student = current_company.students.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def my_data
    @student = current_company.students.find(params[:id])
  end

  def my_exams

  end

  def edit
  end

  def create
    @student = current_company.students.new(student_params)

    @student.save

    respond_with @student, :location => students_path
  end

  def update
    @student = current_company.students.find(params[:id])

    @student.update_attributes(student_params)

    if current_user.profile == "student"
      respond_with @student, :location => my_data_student_path(@student)
    else
      respond_with @student, :location => students_path
    end

  end

  def destroy
    @student = current_company.students.find(params[:id])

    @student.destroy

    respond_with @student, :location => @student

  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:name,:street, :house_number, :complement, :zip_code, :neighborhood,
                                      :district, :city, :federal_unit, :email, :birth_date, :phone)
    end
end