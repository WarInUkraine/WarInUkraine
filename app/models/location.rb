class Location < ActiveRecord::Base
  # Associations
  belongs_to :locatable, polymorphic: true

  # Validation
  validates :lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # Constants
  DONETSK_LAT = 48.202778
  DONETSK_LNG = 37.805278
end
