class Static < ActiveRecord::Base
  # Validation
  validates :url, uniqueness: true
end
