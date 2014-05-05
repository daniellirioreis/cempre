class AnswersController < ApplicationController
  before_filter :authorize_controller!

  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = current_company.answers
  end

  def show

  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = current_company.answers.new(answer_params)

    @answer.save

    respond_with @answer, :location => answers_path
  end

  def update
    @answer = current_company.answers.find(params[:id])

    @answer.update_attributes(answer_params)

    respond_with @answer, :location => answers_path
  end



  private
    def set_answer
      @answer = answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:name, :company_id, :type_question)
    end
end