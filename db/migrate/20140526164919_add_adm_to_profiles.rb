class AddAdmToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :adm, :boolean, default: false
  end
end
