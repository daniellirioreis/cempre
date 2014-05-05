class BirthdaysMonthsController< ApplicationController

  def index
  end

  def print
    @groups = current_calendar.groups_active.bithday(params[:month])
  end
end