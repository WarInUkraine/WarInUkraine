class Comment < ActiveRecord::Base
  # Associations
  belongs_to :commentable, polymorphic: true

  # Validation
  validates :commentable, presence: true
  validates :text, length: { minimum: 6 }

  # Enumerable
  enum status: {
    draft: 0,
    published: 1,
    removed: 2
  }

  # Scopes
  default_scope { published }
end
