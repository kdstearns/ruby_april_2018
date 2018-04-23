class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user

  validates :content, :user, presence: :true
end
