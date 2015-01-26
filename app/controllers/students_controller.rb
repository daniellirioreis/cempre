class StudentsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_student, only: [:show, :edit, :update, :destroy, :my_data, :my_exams, :declaration_of_studying, :bulletin, :frequency]

  def bulletin
    @groups_approved = @student.groups.approved
  end

  def frequency

  end

  def index
    @students = current_company.students.sorted
    @groups_second_change_exam = []
    
    unless current_calendar.nil?
      @groups_second_change_exam = current_calendar.groups_second_change_exam  if params[:second_change_exam] == 'true'
      @children = current_calendar.groups_active  if params[:children] == 'true'
      
      @groups_active = current_calendar.groups_active.closed_for_enrollments  if params[:enrolled] == 'true'
      
      

      # @groups_down_average = @groups_active.down_average(current_calendar.average)
      # unless params[:type_exam].nil?
      #   case params[:type_exam].to_i
      #     when TypeExam::FINAL
      #       @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
      #     when TypeExam::MIDTERM
      #       @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
      #     when TypeExam::ORAL
      #       @groups_down_average = @groups_down_average.type_exam(params[:type_exam])
      #   end
      # end
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
    if current_user.student? 
      @student =  current_user.student
    else
      @student = current_company.students.find(params[:id])      
    end      

    # data_table = GoogleVisualr::DataTable.new
    # data_table.new_column('string', 'Year')
    # data_table.new_column('number', 'Sales')
    # data_table.add_rows(2)
    # data_table.set_cell(0, 0, 'janeiro')
    # data_table.set_cell(0, 1, 1000)
    # data_table.set_cell(0, 2, 400)
    # data_table.set_cell(1, 0, 'Fevereiro')
    # data_table.set_cell(1, 1, 1170)
    # data_table.set_cell(1, 2, 460)
    # 
    # 
    # opts   = { :width => 700, :height => 400, :title => 'Company Performance', :legend => 'bottom' }
    # @chart = GoogleVisualr::Interactive::LineChart.new(data_table, opts)
    # 

  end

  def new
    @student = Student.new
  end

  def my_data
    if current_user.student.nil?
      flash[:info] = 'Opção válida somente para usuário aluno'
      redirect_to @student
    else
      @student = current_user.student
    end
  end

  def my_exams

  end

  def edit
  end

  def create
    @student = current_company.students.new(student_params)

    @student.save

    respond_with @student, :location => @student
  end

  def update
    @student = current_company.students.find(params[:id])

    @student.update_attributes(student_params)

    respond_with @student, :location => @student

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
                                      :district, :city, :federal_unit, :email, :birth_date, :phone, :block_schedule_different, :cell_phone, :document, :obs, :mother, :father, :link_photo, :start_class)
    end
end