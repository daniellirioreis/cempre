class LessonsController < ApplicationController
  before_filter :authorize_controller!
  before_action :set_classroom, only: [:index, :new, :create]

  def index
    @lessons = @classroom.lessons
  end

  def new
    @lesson =  Lesson.new(classroom_id: @classroom.id)
  end

  def create
    @lesson = Lesson.new(lesson_params)

    @lesson.save

    respond_with @lesson, :location => lessons_path(:classroom_id => @lesson.classroom_id)
  end

  def update
    @lesson = Lesson.find(params[:id])

    @lesson.update_attributes(lesson_params)

    respond_with @lesson, :location => lessons_path(:classroom_id => @lesson.classroom_id)
  end

  def destroy
    @lesson = Lesson.find(params[:id])

    @lesson.destroy

    respond_with @lesson, :location => new_group_path(:classroom_id => @lesson.classroom_id)

  end


  private

  def set_classroom
    @classroom = Classroom.find(params[:classroom_id])
  end


  def lesson_params
    params.require(:lesson).permit(:classroom_id, :calendar_day_id)
  end

end