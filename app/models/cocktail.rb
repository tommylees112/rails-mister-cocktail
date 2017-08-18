class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name, presence: true, uniqueness: true

  mount_uploader :photo, PhotoUploader
  # Saying let the photo string be a photo uploader button ! :D
end
