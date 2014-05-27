class CreateCompaniesUsers < ActiveRecord::Migration
  def change
    create_table :companies_users, :id => false do |t|
      t.references :company
      t.references :user
    end
    add_foreign_key :companies_users, :companies
    add_foreign_key :companies_users, :users
  end

end
