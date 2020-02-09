class EditApplictionsTablesName < ActiveRecord::Migration[5.1]
  def change
   rename_table :applications_tables, :applications
 end
end
