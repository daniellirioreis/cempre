class AddCurrentCompanyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_company_id, :integer
  end
end
