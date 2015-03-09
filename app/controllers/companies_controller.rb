class CompaniesController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def report_calendar

  end

  def print_informations
      @approved = current_calendar.groups_approved.count 
      @failed = current_calendar.groups_failed.count
      @folded = current_calendar.groups_folded
      @locked = current_calendar.groups_locked.count
      @active = current_calendar.groups_active.count
    
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Task')
      data_table.new_column('number', 'Hours per Day')
      data_table.add_rows(5)
      data_table.set_cell(0, 0, 'Aprovados'     )
      data_table.set_cell(0, 1, @approved )
      data_table.set_cell(1, 0, 'Reprovados'      )
      data_table.set_cell(1, 1, @failed  )
      data_table.set_cell(2, 0, 'Abandonou'  )
      data_table.set_cell(2, 1, @folded  )
      data_table.set_cell(3, 0, 'Matricula Trancada'  )
      data_table.set_cell(3, 1, @locked)
      data_table.set_cell(4, 0, 'Ativo'  )
      data_table.set_cell(4, 1, @active)
      opts   = { :width => 1000, :height => 400, :title => "Gráfico Alunos #{current_calendar}", :is3D => true }
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
      
      
  end

  def index
    if current_user.adm
      @companies = Company.all
    else
      @companies = current_user.companies
    end

    respond_with(@companies)
  end

  def show
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Task')
    data_table.new_column('number', 'Hours per Day')
    data_table.add_rows(5)
    data_table.set_cell(0, 0, 'Aprovados'     )
    data_table.set_cell(0, 1, current_calendar.groups_approved.count )
    data_table.set_cell(1, 0, 'Reprovados'      )
    data_table.set_cell(1, 1, current_calendar.groups_failed.count  )
    data_table.set_cell(2, 0, 'Abandonou'  )
    data_table.set_cell(2, 1, current_calendar.groups_folded.count  )
    data_table.set_cell(3, 0, 'Matricula Trancada'  )
    data_table.set_cell(3, 1, current_calendar.groups_locked.count  )
    data_table.set_cell(4, 0, 'Ativo'  )
    data_table.set_cell(4, 1, current_calendar.groups_active.count  )
    
    
    
    opts   = { :width => 1000, :height => 500, :title => "Gráfico Alunos #{current_calendar}", :is3D => true }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
    
    

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Task')
    data_table.new_column('number', 'Hours per Day')
    data_table.add_rows(2)
    data_table.set_cell(0, 0, 'Acima da Media'     )
    data_table.set_cell(0, 1, current_calendar.groups.up_average(current_calendar.average).type_exam(TypeExam::MIDTERM).count)
    data_table.set_cell(1, 0, 'Abaixo da Média'      )
    data_table.set_cell(1, 1, current_calendar.groups.down_average(current_calendar.average).type_exam(TypeExam::MIDTERM).count)
    
    
    
    opts   = { :width => 1000, :height => 500, :title => "Gráfico prova MIDTERM", :is3D => true }
    @chart1 = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
    
    
  end

  def new
    @company = Company.new
    respond_with(@company)
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    @company.save
    respond_with @company, :location => companies_path
  end

  def update
    @company.update(company_params)
    respond_with @company, :location => companies_path
  end

  def destroy
    @company.destroy
    respond_with(@company)
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :vacancy, :street, :house_number, :complement, :zip_code, :neighborhood,
                                      :district, :city, :federal_unit, :email, :phone)
    end
end
