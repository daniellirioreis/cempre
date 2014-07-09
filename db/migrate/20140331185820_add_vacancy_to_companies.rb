class AddVacancyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :vacancy, :integer, default: 0
  end
end
