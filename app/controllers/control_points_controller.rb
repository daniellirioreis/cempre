class ControlPointsController < ApplicationController
  before_filter :authorize_controller!
  
  before_action :set_teacher, only: [:new, :check, :info]

  before_action :set_calendar_day, only: [:new, :show, :update, :edit, :update, :destroy, :check, :info]
  
  before_action :set_control_point, only: [:show, :update, :edit, :update, :destroy]

  before_action :check, only: [:new]
  
  
  
  def index
    @teachers = current_company.teachers.monitor
  end
  
  def info
    if params[:month].blank?
      params[:month] = Date.today.month
    end        
    
    @control_points = @teacher.control_points.calendar_id_and_month(current_calendar.id, params[:month])
        
  end
  
  def new
    unless current_user.adm 
      @time_now = Time.now  - 3.hours        
      @control_point = ControlPoint.new(teacher_id: @teacher.id, calendar_day_id: @calendar_day.id, time_start: @time_now)      
    else
      @control_point = ControlPoint.new(teacher_id: @teacher.id)            
    end
  end

  def edit
     unless current_user.adm
       @control_point = ControlPoint.find(params[:id])       
     else
       @time_now = Time.now  - 3.hours
       @control_point = ControlPoint.find(params[:id])
       @control_point.time_end = @time_now    
       @control_point.closed = true       
     end
  end
  
  def create
    @control_point = ControlPoint.new(control_point_params)

    @control_point.save

    respond_with @control_point, :location => control_points_path
  end

  def update
    @control_point = ControlPoint.find(params[:id])

    @control_point.update_attributes(control_point_params)

    respond_with @control_point, :location => control_points_path
  end
  
  def destroy
    @control_point = ControlPoint.find(params[:id])       

    @control_point.destroy

    respond_with @control_point, :location => info_control_points_path(teacher_id: @control_point.teacher_id)

  end
  
  
  
  private
    
    def check
      unless current_user.adm
        @control_point = ControlPoint.find_by_teacher_id_and_calendar_day_id_and_closed(@teacher.id, @calendar_day.id, false)
        redirect_to edit_control_point_path(@control_point) if @control_point.present?        
      end      
    end
    
    def set_control_point
      @control_point = ControlPoint.find(params[:id])
    end
    
    def set_calendar_day 
      unless current_user.adm
        @calendar_day =  CalendarDay.find_by_day_and_calendar_id(Date.today, current_calendar.id)        
      end
    end
    
    
    def set_teacher
      @teacher = Teacher.find(params[:teacher_id])
    end
    

    def control_point_params
      params.require(:control_point).permit(:teacher_id, :calendar_day_id, :time_start, :time_end, :closed)
    end
  
  
end
