class Author < ActiveRecord::Base
  # has_many :author_posts
  # has_many :posts, through: :author_posts
  has_many :posts

  scope :old, -> { where('age > 30') }
  scope :young, -> { where('age < 20') }
  scope :oneandonly, -> { find_by(name: 'Bob') }

  before_create :default_age

  validates :name, :surname, presence: true

  def fullname
    "#{name} #{surname}"
  end

  def self.delete_old_authors
    Author.old.destroy_all
  end

  private

  def default_age
    self.age = 25 unless age
  end
end
