class CreateVaccinationForms < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccination_forms do |t|
      t.string :company
      t.string :number
      t.string :nonumber
      t.string :name
      t.integer :phone
      t.integer :response_id

      t.timestamps
    end
  end
end
