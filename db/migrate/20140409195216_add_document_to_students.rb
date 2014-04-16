class AddDocumentToStudents < ActiveRecord::Migration
  def change
    add_column :students, :document, :string
  end
end
