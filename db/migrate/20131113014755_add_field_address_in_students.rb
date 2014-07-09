class AddFieldAddressInStudents < ActiveRecord::Migration
  def change
    add_column :students, :street, :string, limit: 50
    add_column :students, :house_number, :string, limit: 8
    add_column :students, :complement, :string, limit: 20
    add_column :students, :zip_code, :string, limit: 10
    add_column :students, :neighborhood, :string, limit: 50
    add_column :students, :city, :string, limit: 50
    add_column :students, :federal_unit, :integer
  end

end