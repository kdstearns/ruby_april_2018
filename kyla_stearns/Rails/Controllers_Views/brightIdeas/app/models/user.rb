class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts_liked, through: :likes, source: :post

  has_secure_password
  # bcrypt will already validate if password is blank, if confirmation matches, etc.
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
  # usually can use before_save but since my regex doesn't allow for caps, this has to run before validation
  before_validation :downcase_fields  
  
  validates :name, :alias, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 8, maximum: 15 }, on: :create

  private 
	def downcase_fields
	  self.email.downcase!
	end
end
