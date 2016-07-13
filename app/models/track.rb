class Track < ActiveRecord::Base
  belongs_to :user
  has_many :upvotes
  has_many :reviews
  validates :song_title, presence: true
  validates :author, presence: true
end
