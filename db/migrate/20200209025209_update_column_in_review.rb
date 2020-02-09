class UpdateColumnInReview < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :shelters_id, :shelter_id
  end
end
