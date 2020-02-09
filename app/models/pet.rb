class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :shelter
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
end
