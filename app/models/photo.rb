class Photo < ApplicationRecord
  has_many :interactions
  belongs_to :user
  belongs_to :brand, optional: true
end
