class User < ActiveRecord::Base
  # Authorization module
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :news, dependent: :destroy

  # Validation
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Filters
  before_save :capitalize_name

  def author?(object)
    self.id == object.try(:user_id)
  end

  def to_s
    "#{self.first_name} #{self.last_name}"
  end

  private  
  def capitalize_name
    self.first_name.capitalize!
    self.last_name.capitalize!
  end
end
