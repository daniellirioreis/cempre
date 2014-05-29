class FaultsController < ApplicationController
  before_filter :authorize_controller!

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

  def create_with_click
    group = Group.find(params[:group_id])
    @fault = group.faults.find_by_group_id_and_lesson_id(params[:group_id], params[:lesson_id])
    unless @fault.nil?
      @fault.destroy
      flash[:info] = 'Falta apagada com sucesso'
    else
      @fault = Fault.new(group_id: params[:group_id], lesson_id: params[:lesson_id], justification: JustificationsFault::NONE)
      if @fault.save
        flash[:info] = 'Falta criada com sucesso'
      else
        flash[:alert] = 'ocorreu um erro no lançamento de falta'
      end
    end

    redirect_to throw_faults_classroom_path(@fault.group.classroom)

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