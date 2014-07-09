class AddCellPhoneToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :cell_phone, :string
  end
end
