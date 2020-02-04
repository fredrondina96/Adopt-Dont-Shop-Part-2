class AddColumnShelterToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :shelter_id, :string
  end
end
