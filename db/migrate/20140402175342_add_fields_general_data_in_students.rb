class AddFieldsGeneralDataInStudents < ActiveRecord::Migration
  def change
    add_column :students, :birth_date, :date
    add_column :students, :phone, :string
  end
end
