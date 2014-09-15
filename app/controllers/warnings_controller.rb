class WarningsController < ApplicationController
  before_action :set_warning, only: [:show, :edit, :update, :destroy]
  before_action :set_student, only: [:new, :update, :create]
  def index
    @warnings = Warning.all
    respond_with(@warnings)
  end

  def show
    respond_with(@warning)
  end

  def new
    @warning = Warning.new(student_id: @student.id)
    respond_with(@warning)
  end

  def edit
    @student = @warning.student
  end

  def create
    @warning = Warning.new(warning_params)
    @warning.save
    respond_with @warning, :location => @warning.student
    
  end

  def update
    @warning.update(warning_params)
    respond_with @warning, :location => @warning.student
  end

  def destroy
    @warning.destroy
    respond_with @warning, :location => @warning.student
  end

  private
    def set_warning
      @warning = Warning.find(params[:id])
    end
    
    def set_student
      @student = Student.find(params[:student_id])
    end
    

    def warning_params
      params.require(:warning).permit(:student_id, :description, :calendar_day_id)
    end
end
