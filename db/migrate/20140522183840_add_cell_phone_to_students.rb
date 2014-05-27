class AddCellPhoneToStudents < ActiveRecord::Migration
  def change
    add_column :students, :cell_phone, :string
  end
end
