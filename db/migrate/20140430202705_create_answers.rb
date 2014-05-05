class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :name
      t.integer :type_question
      t.references :company, index: true

      t.timestamps
    end
    add_foreign_key :answers, :companies
  end
end
