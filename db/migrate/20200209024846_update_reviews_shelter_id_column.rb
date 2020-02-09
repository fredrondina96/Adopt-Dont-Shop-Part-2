class UpdateReviewsShelterIdColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :shelter_id
    add_reference :reviews, :shelters, foreign_key: true
  end
end
