class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.references :group, index: true

      t.timestamps
    end
    add_foreign_key :questionnaires, :groups
  end
end
