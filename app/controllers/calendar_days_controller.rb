class CalendarDaysController < ApplicationController
  before_action :set_calendar_day, only: [:show, :edit, :update, :destroy]

  def index
    @calendar_days = CalendarDay.all
    respond_with(@calendar_days)
  end

  def show
    respond_with(@calendar_day)
  end

  def new
    @calendar_day = CalendarDay.new
    respond_with(@calendar_day)
  end

  def edit
  end

  def create
    @calendar_day = CalendarDay.new(calendar_day_params)
    @calendar_day.save
    respond_with(@calendar_day)
  end

  def update
    @calendar_day.update(calendar_day_params)
    respond_with(@calendar_day)
  end

  def destroy
    @calendar_day.destroy
    respond_with(@calendar_day)
  end

  private
    def set_calendar_day
      @calendar_day = CalendarDay.find(params[:id])
    end

    def calendar_day_params
      params.require(:calendar_day).permit(:day)
    end
end
