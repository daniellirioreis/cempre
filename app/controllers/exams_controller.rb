class ExamsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  def index
    @exams = Exam.find_all_by_group_id(params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def new
    @exam = Exam.new(group_id: params[:group_id])
  end

  def destroy
    @exam = Exam.find(params[:id])

    @exam.destroy

    respond_with @exam, :location => @exam.group.classroom
  end

  def create
    @exam = Exam.new(exam_params)

    @exam.save

    respond_with @exam, :location => @exam.group.classroom
  end


  private
    def set_exam
      @exam = Exam.find(params[:id])
    end

    def exam_params
      params.require(:exam).permit(:name, :lesson_id, :group_id, :value, :type_exam)
    end
end