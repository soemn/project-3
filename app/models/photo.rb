class Photo < ApplicationRecord
  has_many :interactions
  belongs_to :user
end
