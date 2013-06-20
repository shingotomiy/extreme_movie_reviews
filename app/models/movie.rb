class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :likes, as: :likeable
  has_many :recent_movies

  attr_accessible :title, :year
  validates_uniqueness_of :title, :scope => :year, :message => 'Movie already created'
  validates_presence_of :title, :year, :message => "Invalid Criteria"
  validates :year, :inclusion => 1875..(Time.now.year + 1)


  def unique_review?(current_user)
    self.reviews.where(:user_id => current_user.id).empty?
  end


end




# movie.reviews.where(:user_id => user.id)
