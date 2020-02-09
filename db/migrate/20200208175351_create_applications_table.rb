class CreateApplicationsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :applications_tables do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number
      t.string :description
      t.string :description
      t.timestamps
    end
  end
end
