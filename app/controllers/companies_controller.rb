class CompaniesController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def report_calendar

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
    
    
    
    opts   = { :width => 1000, :height => 500, :title => "Grafico Resultados alunos #{current_calendar}", :is3D => true }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
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
