class AddJustificationToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :justification, :text
  end
end
