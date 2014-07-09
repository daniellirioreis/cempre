class AddFieldGeneralInTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :street, :string, limit: 50
    add_column :teachers, :house_number, :string, limit: 8
    add_column :teachers, :complement, :string, limit: 20
    add_column :teachers, :zip_code, :string, limit: 10
    add_column :teachers, :neighborhood, :string, limit: 50
    add_column :teachers, :city, :string, limit: 50
    add_column :teachers, :federal_unit, :integer
    add_column :teachers, :phone, :string
    add_column :teachers, :email, :string
    add_column :teachers, :birth_date, :date
  end
end
