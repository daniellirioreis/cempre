class AddPhoneToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :phone, :string
  end
end
