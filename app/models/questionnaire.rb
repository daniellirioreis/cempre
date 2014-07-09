class Questionnaire < ActiveRecord::Base
  belongs_to :group
  validates :group_id, presence: true
  has_many :questions, :class_name => "QuestionnaireQuestion", :foreign_key => "questionnaire_id"

  delegate :company, to: :group

  after_save :build_questions

  protected

  def build_questions
    company.questions.each do |q|
      qq = QuestionnaireQuestion.new(questionnaire_id: id , question_id: q.id)
      qq.save
    end
  end
end
