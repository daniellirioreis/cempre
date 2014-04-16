class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name

      t.timestamps
    end
    #create company record
    company = Company.new(name: "Cempre")
    company.save
  end
end
