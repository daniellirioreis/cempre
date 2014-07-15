class PlansController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_plan, only: [:show, :edit, :update, :destroy, :report]
  before_action :set_calendar, only: [:new, :create, :index, :edit, :update]

  def report
    
  end
  
  def show

  end

  def index
    @plans  = @calendar.plans
  end

  def new
    @plan = Plan.new(calendar_id: @calendar.id)
  end

  def create
    @plan = Plan.new(plan_params)

    @plan.save

    respond_with @plan, :location => plans_path(calendar_id: @plan.calendar_id)
  end

  def update
    @plan = Plan.find(params[:id])

    @plan.update_attributes(plan_params)

    respond_with @plan, :location => plans_path(calendar_id: @plan.calendar_id)
    
  end
  
  def destroy
    @plan = Plan.find(params[:id])

    @plan.destroy

    respond_with @plan, :location => plans_path(calendar_id: @plan.calendar_id)

  end
  

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def set_calendar
    @calendar = Calendar.find(params[:calendar_id])
  end


  def plan_params
    params.require(:plan).permit(:course_id, :calendar_id, :day_week, :book, :minutes_for_class)
  end
end
