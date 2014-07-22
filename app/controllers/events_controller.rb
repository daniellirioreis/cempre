class EventsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_event, only: [:show, :edit, :update, :destroy, :finalize]

  def new
    @event = Event.new(calendar_day_id: params[:calendar_day_id])
  end

  def create
    @event = Event.new(event_params)

    @event.save

    respond_with @event, :location => calendar_path(id: @event.calendar_day.calendar, calendar_day_id: @event.calendar_day_id )
  end

  def edit
  end

  def destroy 
    @event.destroy    
    
    respond_with @event, :location => calendar_path(id: @event.calendar_day.calendar, calendar_day_id: @event.calendar_day_id )
    
  end

  def finalize
    if @event.closed
      flash[:notice] = 'Evento aberto com sucesso'
      @event.update_attribute(:closed, false)
    else
      flash[:notice] = 'Evento finalizado com sucesso'
      @event.update_attribute(:closed, true)
    end

    redirect_to root_path
  end

  def update
    @event = Event.find(params[:id])

    @event.update_attributes(event_params)

    respond_with @event, :location => calendar_path(id: @event.calendar_day.calendar, calendar_day_id: @event.calendar_day_id )
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:calendar_day_id, :description, :type_event, :time_start, :time_end, :teacher_id, :student_id)
    end
end