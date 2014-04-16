class FaultsController < ApplicationController
  before_action :set_fault, only: [:show, :edit, :update, :destroy]

  def index
    @faults = Fault.find_all_by_group_id(params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def new
    @fault = Fault.new(group_id: params[:group_id])
  end

  def create
    @fault = Fault.new(fault_params)

    @fault.save

    respond_with @fault, :location => @fault.group.classroom
  end

  def edit

  end

  def update
    @fault = Fault.find(params[:id])

    @fault.update_attributes(fault_params)

    respond_with @fault, :location => @fault.group.classroom
  end

  def destroy
    @fault = Fault.find(params[:id])

    @fault.destroy

    respond_with @fault, :location => @fault.group.classroom
  end

  private
    def set_fault
      @fault = Fault.find(params[:id])
    end

    def fault_params
      params.require(:fault).permit(:group_id, :lesson_id, :justification)
    end

end