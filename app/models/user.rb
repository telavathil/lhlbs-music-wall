class User < ActiveRecord::Base
  has_many :tracks
  has_many :upvotes
  has_many :reviews
  validates :email, presence: true
  validates :password, presence: true
end
