class Author < ActiveRecord::Base
  # has_many :author_posts
  # has_many :posts, through: :author_posts
  has_many :posts

  validates :name, :surname, presence: true

  def fullname
    "#{name} #{surname}"
  end
end
