class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :type_question
      t.references :company, index: true
      t.timestamps
    end
    add_foreign_key :questions, :companies
  end
end