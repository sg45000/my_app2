class Genre < ApplicationRecord
  has_and_belongs_to_many :videos
  validates :name, uniqueness: true 
end
