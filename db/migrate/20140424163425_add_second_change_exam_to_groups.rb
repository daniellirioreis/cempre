class AddSecondChangeExamToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :second_change_exam, :boolean, default: false
  end
end
