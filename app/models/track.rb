class Track < ApplicationRecord
  belongs_to :train

  validates :name, presence: true
end
