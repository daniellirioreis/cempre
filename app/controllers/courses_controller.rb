class CoursesController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_course, only: [:show, :edit, :update, :destroy, :buy_books]

  def buy_books
    @groups =  @course.groups(current_calendar.id).sorted
  end
  
  def index
    @courses = current_company.courses.sorted
  end

  def show
    @course = current_company.courses.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = current_company.courses.new(course_params)

    @course.save

    respond_with @course, :location => courses_path

  end

  def update
    @course = current_company.courses.find(params[:id])

    @course.update_attributes(course_params)

    respond_with @course, :location => courses_path
  end

  def destroy
    @course = current_company.courses.find(params[:id])

    @course.destroy

    respond_with @course, :location => courses_path
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:company_id, :name, :type_course, :sequence, :level_course, :buy_the_book)
    end
end
