class QuestionnaireQuestion < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :question
  belongs_to :answer

  delegate :type_question, :type_question_humanize, to: :question

  validates :questionnaire_id, :question_id, presence: true

  validates :question_id, uniqueness: { scope: :questionnaire_id }


  def to_s
    question
  end

  def type_question_value
    type_question
  end
end
