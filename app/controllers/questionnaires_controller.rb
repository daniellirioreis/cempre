class QuestionnairesController < ApplicationController

  def generate
    questionnaire = Questionnaire.new(group_id: params[:group_id])

    if questionnaire.save
      flash[:info] = 'Questionario gerado com sucesso'
      redirect_to questionnaire_group_path(params[:group_id])
    else
      flash[:alert] = 'Questionário não pode ser gerado'
    end
  end
end