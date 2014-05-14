class QuestionnaireQuestionsController < ApplicationController

  before_action :set_questionnaire_question, only: [:show, :edit, :update, :destroy]

  def new
    @questionnaire_question = QuestionnaireQuestion.new(questionnaire_id: params[:questionnaire_id])
  end

  def edit

  end

  def destroy
    @questionnaire_question = QuestionnaireQuestion.find(params[:id])

    @questionnaire_question.destroy

    respond_with @questionnaire_question, :location => exams_path(group_id: @questionnaire_question.questionnaire.group_id)

  end


  def create
    @questionnaire_question = QuestionnaireQuestion.new(questionnaire_question_params)

    @questionnaire_question.save

    respond_with @questionnaire_question, :location => questionnaire_group_path(@questionnaire_question.questionnaire.group)
  end

  def update
    @question = QuestionnaireQuestion.find(params[:id])

    @question.update_attributes(questionnaire_question_params)

    respond_with @questionnaire_question, :location => exams_path(group_id: @questionnaire_question.questionnaire.group_id)
  end


  private
    def set_questionnaire_question
      @questionnaire_question = QuestionnaireQuestion.find(params[:id])
    end

    def questionnaire_question_params
      params.require(:questionnaire_question).permit(:answer_id, :questionnaire_id, :question_id)
    end

end