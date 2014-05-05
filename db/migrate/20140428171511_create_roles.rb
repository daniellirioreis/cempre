class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :controller, :null => false
      t.string :action, :null => false

      t.timestamps
    end
  end
end
