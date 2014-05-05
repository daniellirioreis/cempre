class StudentsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_student, only: [:show, :edit, :update, :destroy, :my_data, :my_exams, :declaration_of_studying, :bulletin]

  def bulletin
    @groups_approved = @student.groups.approved
  end

  def index
    @students = current_company.students.sorted

    unless current_calendar.nil?
      @groups_second_change_exam = current_calendar.groups_second_change_exam
      @groups_active = current_calendar.groups_active
      @groups_down_average = @groups_active.down_average(current_calendar.average)

      unless params[:type_exam].nil?
        case params[:type_exam].to_i
          when TypeExam::FINAL
            @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
          when TypeExam::MIDTERM
            @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
          when TypeExam::ORAL
            @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
        end
      end
    else
      @groups_second_change_exam = []
      @groups_down_average = []
    end
  end

  def down_average
    @groups_down_average = current_calendar.groups_active.down_average(current_calendar.average)
    unless params[:type_exam].nil?
      case params[:type_exam].to_i
        when TypeExam::FINAL
          @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
        when TypeExam::MIDTERM
          @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
        when TypeExam::ORAL
          @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
      end
    end
  end

  def declaration_of_studying
    @groups = @student.groups.active
    @quant_groups = @groups.count
    if @groups.nil?
      flash[:info] = 'Aluno não possui matricula ativa'
      redirect_to @student
    end
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

    respond_with @student, :location => students_path

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