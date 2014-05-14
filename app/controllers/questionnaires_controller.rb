class QuestionnairesController < ApplicationController
  before_action :set_group, only: [:index, :new, :show, :edit, :update, :destroy]

  before_filter :authorize_controller!

  def index
    @group
  end

  def new
    @questionnaire = Questionnaire.new(group_id: @group.id)
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)

    @questionnaire.save

    respond_with @questionnaire, :location => exams_path(group_id: @questionnaire.group_id)

  end


  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:group_id)
  end

end