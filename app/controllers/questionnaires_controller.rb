class QuestionnairesController < ApplicationController
  before_action :set_group, only: [:index, :show, :edit, :update, :destroy]

  before_filter :authorize_controller!

  def index
    @group
  end

  def generate
    questionnaire = Questionnaire.new(group_id: params[:group_id])

    if questionnaire.save
      flash[:info] = 'Questionario gerado com sucesso'
      redirect_to questionnaire_group_path(params[:group_id])
    else
      flash[:alert] = 'Questionário não pode ser gerado'
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end
end