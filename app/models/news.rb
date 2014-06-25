class News < ActiveRecord::Base
  # Serialize
  serialize :youtube_data

  # Associations
  belongs_to :user
  has_one :location,  as: :locatable,   dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :location

  # Validation
  validates :title, presence: true, length: { maximum: 128 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :text, presence: true, if: 'youtube_url.empty?'
  validates :location, presence: true
  validate  :validate_youtube_url, if: '!youtube_url.empty? && youtube_url_changed?'

  # Enumerable
  enum status: {
    draft: 0,
    published: 1,
    removed: 2
  }

  # Scopes
  default_scope { published }

  # Filters
  before_validation :set_happened_at
  before_save       :update_video_data

  def video(force = false)
    return @video if defined?(@video) && !force
    @video = $youtube.video_by(self.youtube_url)

    @video
  end

  def to_s
    self.title
  end

  private
  def set_happened_at
    self.happened_at ||= Time.now
  end

  def validate_youtube_url
    $youtube.video_by(self.youtube_url)
  rescue
    errors.add(:youtube_url, 'указана неверно')
  end

  def update_video_data
    return unless youtube_url_changed?
    self.youtube_data = self.video(true)
  end
end
