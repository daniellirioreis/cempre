class AddFieldsOfAddressInCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :street, :string, limit: 50
    add_column :companies, :house_number, :string, limit: 8
    add_column :companies, :complement, :string, limit: 20
    add_column :companies, :zip_code, :string, limit: 10
    add_column :companies, :neighborhood, :string, limit: 50
    add_column :companies, :city, :string, limit: 50
    add_column :companies, :federal_unit, :integer
  end
end
