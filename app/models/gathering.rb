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
  def positive_total(collection)
    collection.select do |item|
       upvotes = (item.upvotes)
       downvotes = (item.downvotes)
       upvotes > downvotes
     end
  end

# other filters:

  def vote_ratio(item_collection)

  end

  def final_pick(item_collection)
    item_collection.sample
  end


  # @positive_total = ->(collection){
  #   collection.select do |item|
  #     upvotes = (item.upvotes)
  #     downvotes = (item.downvotes)
  #     upvotes > downvotes
  #   end
  # }


  def find_best(item)
    collection = self.send(item.to_s.pluralize)

    collection = positive_total(collection)
  end


end
