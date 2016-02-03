class Gathering < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :interests, dependent: :destroy
  has_many :users, through: :interests
  has_many :moments
  has_many :activities
  has_many :places
  has_many :comments
  has_one :finalized_plan

  # cascading filters
  #   pass in array of gathering.moments

  # F1
  def upvote_ratio #item as arg
    self.places.select do |place|
      upvotes = (place.upvotes)
      downvotes = (place.downvotes)
      upvotes > downvotes
    end
  end





  def find_best(item)
    votable = Object.const_get(item)

  end


end
