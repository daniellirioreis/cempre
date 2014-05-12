class SchedulesController < ApplicationController

  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def edit

  end

  def update
    @schedule = Schedule.find(params[:id])

    @schedule.update_attributes(schedule_params)

    respond_with @schedule, :location => @schedule.plan
  end

  def destroy
    @schedule = Schedule.find(params[:id])

    @schedule.destroy

    respond_with @schedule, :location => @schedule.plan
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:calendar_day_id, :description, :plan_id)
  end
end