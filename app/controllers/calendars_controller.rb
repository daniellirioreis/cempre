class CalendarsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_calendar, only: [:show, :edit, :update, :destroy, :finalize, :results, :classrooms, :events]

  def classrooms
    @classrooms = @calendar.classrooms
  end

  def events
    @events = @calendar.events
  end

  def finalize
      if params[:yes_or_no] == 'true'
        @calendar.update_attribute(:closed, true)
          @calendar.classrooms.each do |c|
            c.update_attribute(:closed, true)
          end
        flash[:info] = "#{@calendar} foi encerrado com sucesso !"
      else
        @calendar.update_attribute(:closed, false)
          @calendar.classrooms.each do |c|
            c.update_attribute(:closed, false)
          end
          flash[:info] = "#{@calendar} aberto com sucesso !"
      end
     redirect_to calendars_path
  end

  def results
    @groups = Group.no_transfer.calendar_id(@calendar.id)

    case params[:status]
      when 'approved'
        @groups = @groups.approved
      when 'failed'
        @groups = @groups.failed
      when 'active'
        @groups = @groups.active
    end

    @quant_approved = Group.approved.calendar_id(@calendar.id).count
    @quant_failed = Group.failed.calendar_id(@calendar.id).count
    @quant_active = Group.active.calendar_id(@calendar.id).count
  end

  def index
    @calendars = current_company.calendars
  end

  def show
    # @calendar_days = @calendar.days
      @calendar_days = []
      @all_days = @calendar.days
     if @calendar.present?
       if params[:day].present?
         data = params[:day]
         unless data.chars.count == 10
           data = Date.today
         else
           data = Date.parse(data[6,4]+'-'+data[3,2]+'-'+data[0,2])
         end
         @calendar_days = @calendar.days.search(data)
       else
         @calendar_days = @calendar.days.search(Date.today)
       end
       if params[:calendar_day_id].present?
         @calendar_days = @calendar.days.find_all_by_id(params[:calendar_day_id])
        end
     end
     rescue ArgumentError
  end

  def new
    @calendar = Calendar.new
  end

  def edit
  end

  def create
    @calendar = current_company.calendars.new(calendar_params)

    @calendar.save

    respond_with @calendar, :location => calendars_path
  end

  def update
    @calendar = current_company.calendars.find(params[:id])

    @calendar.update_attributes(calendar_params)

    respond_with @calendar, :location => calendars_path
  end

  def destroy
    @calendar.destroy
  end

  private
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def calendar_params
      params.require(:calendar).permit(:date_start, :date_end, :name, :average)
    end
end
