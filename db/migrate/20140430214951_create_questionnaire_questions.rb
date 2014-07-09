class CreateQuestionnaireQuestions < ActiveRecord::Migration
  def change
    create_table :questionnaire_questions do |t|
      t.references :questionnaire, index: true
      t.references :question, index: true
      t.references :answer, index: true

      t.timestamps
    end
    add_foreign_key :questionnaire_questions, :questionnaires
    add_foreign_key :questionnaire_questions, :questions
    add_foreign_key :questionnaire_questions, :answers
  end
end
