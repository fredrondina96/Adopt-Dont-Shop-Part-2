class RemoveIdFromPetsTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :shelter_id
    add_reference :pets, :shelter, foreign_key: true
  end
end
