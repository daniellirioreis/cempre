class ManagersController < ApplicationController

  before_action :set_manager, only: [:show, :edit, :update, :destroy, :change_companies]

  before_action :companies, only: [:new, :edit, :update, :create]

  before_filter :authorize_controller!


  def index
    @managers = Manager.all
  end

  def edit

  end

  def change_companies
    @companies = current_user.companies
  end

  def create_calendar
    @company = Company.find(params[:company_id])
    current_user.update_attributes(current_company_id: params[:company_id])
    redirect_to new_calendar_path
  end

  def change_calendars
    current_user.update_attributes(current_calendar_id: params[:calendar_id], current_company_id: params[:company_id])
    redirect_to root_path
  end


  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(manager_params)

    @manager.save

    respond_with @manager, :location => managers_path

  end

  def update
    @manager = Manager.find(params[:id])

    @manager.update_attributes(manager_params)

    respond_with @manager, :location => managers_path

  end

  private

  def companies
    @companies = Company.all
  end


  def set_manager
    @manager = Manager.find(params[:id])
  end

  def manager_params
    params.require(:manager).permit(:name, :email, :password, :password_confirmation, :profile_id, :student_id, :company_ids => [])
  end
end