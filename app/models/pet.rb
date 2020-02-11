class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :shelter
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def has_no_applications?
    applications.empty?
  end

  def approved_application
    applications.where(status: "approved")[0]
  end

  def adoptable?
    adoption_status == "Adoptable"
  end
end
