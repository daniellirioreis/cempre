class AddReEnrollmentToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :re_enrollment, :boolean, default: false
  end
end
