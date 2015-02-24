class EventsController < ApplicationController
  before_filter :authorize_controller!
  respond_to :json, :js
  

  before_action :set_event, only: [:show, :edit, :update, :destroy, :finalize]

  def index
    if current_user.profile.name == "ALUNOS"
      if current_user.student.group_active.present?
        @events = Event.calendar_id(current_user.student.group_active.first.calendar.id).no_finalized
      else
        @events = []
      end
    else
      @events = Event.calendar_id(current_calendar.id).no_finalized      
    end
    
    @event = Event.new
  end
  
  def new
    if params[:second_change_exam] == "true"
       @student = Student.find(params[:student_id])
      @event = Event.new(description: "PROVA 2ª CHAMADA #{@student.name}", type_event: TypeEvent::DAY_TRIAL, student_id: params[:student_id])            
    else
      @event = Event.new(calendar_day_id: params[:calendar_day_id])    
    end  
  end

  def create
    @event = Event.new(event_params)

    @event.save
     
    # EventMailer.information_for_event(@event).deliver if @event.monitoring?
    
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
    
    # EventMailer.information_for_event(@event).deliver if @event.monitoring?
    
    respond_with @event, :location => calendar_path(id: @event.calendar_day.calendar, calendar_day_id: @event.calendar_day_id )
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:calendar_day_id, :description, :type_event, :time_start, :time_end, :teacher_id, :student_id, :closed, :student_came_in_monitoring)
    end
end