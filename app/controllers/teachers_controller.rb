class TeachersController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_teacher, only: [:show, :edit, :update, :destroy, :report_teacher]

  def report_teacher
    @classrooms =  @teacher.classrooms.calendar_id(current_calendar.id)    
    @courses =  current_company.courses    
  end
  
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
    @classrooms =  @teacher.classrooms.calendar_id(current_calendar.id)
    @lessons = @teacher.lessons
    
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Task')
    data_table.new_column('number', 'Hours per Day')
    data_table.add_rows(2)
    data_table.set_cell(0, 0, 'Acima da Media'     )
    data_table.set_cell(0, 1, current_calendar.groups.up_average(current_calendar.average).type_exam(TypeExam::MIDTERM).teacher_id(@teacher.id).count)
    data_table.set_cell(1, 0, 'Abaixo da Média'      )
    data_table.set_cell(1, 1, current_calendar.groups.down_average(current_calendar.average).type_exam(TypeExam::MIDTERM).teacher_id(@teacher.id).count)
    
    
    
    opts   = { :width => 1000, :height => 500, :title => "GRAFICO PROVA MIDTERM", :is3D => true }
    @chart_mid = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
    
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Task')
    data_table.new_column('number', 'Hours per Day')
    data_table.add_rows(2)
    data_table.set_cell(0, 0, 'Acima da Media'     )
    data_table.set_cell(0, 1, current_calendar.groups.up_average(current_calendar.average).type_exam(TypeExam::FINAL).teacher_id(@teacher.id).count)
    data_table.set_cell(1, 0, 'Abaixo da Média'      )
    data_table.set_cell(1, 1, current_calendar.groups.down_average(current_calendar.average).type_exam(TypeExam::FINAL).teacher_id(@teacher.id).count)
    
    
    
    opts   = { :width => 1000, :height => 500, :title => "GRAFICO PROVA FINAL", :is3D => true }
    @chart_final = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Task')
    data_table.new_column('number', 'Hours per Day')
    data_table.add_rows(2)
    data_table.set_cell(0, 0, 'Acima da Media'     )
    data_table.set_cell(0, 1, current_calendar.groups.up_average(current_calendar.average).type_exam(TypeExam::ORAL).teacher_id(@teacher.id).count)
    data_table.set_cell(1, 0, 'Abaixo da Média'      )
    data_table.set_cell(1, 1, current_calendar.groups.down_average(current_calendar.average).type_exam(TypeExam::ORAL).teacher_id(@teacher.id).count)
    
    
    
    opts   = { :width => 1000, :height => 500, :title => "GRAFICO PROVA ORAL", :is3D => true }
    @chart_oral = GoogleVisualr::Interactive::PieChart.new(data_table, opts)


    
  
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
                                      :district, :city, :federal_unit, :email, :birth_date, :phone, :cell_phone, :monitor,
                                      schedule_teachers_attributes: [:id, :time_start, :time_end, :day_week, :_destroy])
    end
end