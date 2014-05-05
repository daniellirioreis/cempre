class QuestionsController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = current_company.questions
  end

  def destroy
    @question = Question.find(params[:id])

    @question.destroy

    respond_with @question, :location => @question

  end

  def show

  end

  def new
    @question = Question.new
  end

  def create
    @question = current_company.questions.new(question_params)

    @question.save

    respond_with @question, :location => questions_path
  end

  def update
    @question = current_company.questions.find(params[:id])

    @question.update_attributes(question_params)

    respond_with @question, :location => questions_path
  end

  def destroy

  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:name, :company_id, :type_question)
    end
end