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
  # def positive_total #item as arg
  #   self.places.select do |place|
  #     upvotes = (place.upvotes)
  #     downvotes = (place.downvotes)
  #     upvotes > downvotes
  #   end
  # end

# other filters:

  def vote_ratio(item_collection)

  end

  def final_pick(item_collection)
    item_collection.sample
  end




  def find_best(item)
    collection = self.send(item.to_s.pluralize)

    positive_total = ->(){
      collection.select do |item|
      upvotes = (item.upvotes)
      downvotes = (item.downvotes)
      upvotes > downvotes}
    }

    positive_total.()

  end


end
