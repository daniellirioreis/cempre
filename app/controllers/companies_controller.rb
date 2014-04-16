class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all
    respond_with(@companies)
  end

  def show
    respond_with(@company)
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
