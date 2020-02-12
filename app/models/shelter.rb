class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def total_pets
    pets.length
  end

  def average_review_rating
    score = 0.0
    total = reviews.length
    reviews.each do |review|
      score += review.rating.to_i
    end
    score / total
  end

  def total_applications
    applications = []
    pets.each do |pet|
      pet.applications.each do |application|
        applications << application.id
      end
    end
    applications.uniq.length
  end
end
