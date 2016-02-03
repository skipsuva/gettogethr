class Gathering < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :interests, dependent: :destroy
  has_many :users, through: :interests
  has_many :moments
  has_many :activities
  has_many :places
  has_many :comments
  has_one :finalized_plan


  def find_best(votable_class)
    #TODO functionalize chain of filters
    collection = self.send(votable_class.to_s.pluralize)

    collection = positive_total(collection)
    collection = vote_ratio(collection)
    collection = shrug_ratio(collection)
    collection = absolute_upvote(collection)
    collection = final_pick(collection)

  end

  private

    # cascading filters

  def positive_total(collection)
    collection.select do |item|
       upvotes = (item.upvotes)
       downvotes = (item.downvotes)
       upvotes > downvotes
     end
  end

  def vote_ratio(collection)
    collection.group_by{|item| (item.upvotes.to_f / item.downvotes.to_f) }.max.last
  end

  def shrug_ratio(collection)
    collection.group_by{|item| (item.upvotes.to_f / item.shrugs.to_f) }.max.last
  end

  def absolute_upvote(collection)
    collection.group_by{|item| item.upvotes }.max.last
  end

  def final_pick(collection)
    collection.sample
  end
end
