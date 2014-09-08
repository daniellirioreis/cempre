class CalendarDaysController < ApplicationController
  respond_to :html, :js, :json
  before_filter :authorize_controller!

  before_action :set_calendar_day, only: [:show, :edit, :update, :destroy]

  def find
     date = Date.parse(params[:date])

     @calendar_day = current_calendar.days.search(date).first
     if @calendar_day.present?
       redirect_to @calendar_day       
     else
       flash[:alert] = 'Data não encontrada, calendário não foi gerado'
       redirect_to current_calendar
     end
  end

  def index
    @calendar_days = current_calendar.days
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
