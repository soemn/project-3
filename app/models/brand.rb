class Brand < ApplicationRecord
  has_many :interactions
  has_many :photos
  belongs_to :user
end
