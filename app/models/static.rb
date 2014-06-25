class Static < ActiveRecord::Base
  # Validation
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  validates :html, presence: true
end
