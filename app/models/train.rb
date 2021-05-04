class Train < ApplicationRecord
  has_many :tracks, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
