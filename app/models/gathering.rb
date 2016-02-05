class Gathering < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :interests, dependent: :destroy
  has_many :users, through: :interests
  has_many :moments
  has_many :activities
  has_many :places
  has_many :comments
  has_one :finalized_plan

  #====================
  include AASM

  aasm do
    state :draft
    state :open, initial: true
    state :finalized
    state :done
    state :cancelled

    event :finalize do
      transitions from: :open, to: :finalized
    end

    event :reopen do
      transitions from: :finalized, to: :open
    end

    event :cancel do
      transitions from: :open, to: :cancelled
      transitions from: :finalized, to: :cancelled
    end

  end


  #====================

  def find_best(votable_class)
    #TODO functionalize chain of filters
    collection = self.send(votable_class.to_s.pluralize)

    if !(filtered_collection = positive_total(collection)).empty?
      collection = filtered_collection
    end

    %w{vote_ratio shrug_ratio absolute_upvote final_pick}.each do |meth|
      return nil if collection.empty?
      collection = send(meth,collection)
    end

    collection

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

  def ratio(a,b)
    return 0 if a == 0
    a.to_f/b.to_f
  end

  def vote_ratio(collection)
    collection.group_by{|item| ratio(item.upvotes,item.downvotes) }.max.last
  end

  def shrug_ratio(collection)
    collection.group_by{|item| ratio(item.upvotes,item.shrugs) }.max.last
  end

  def absolute_upvote(collection)
    collection.group_by{|item| item.upvotes }.max.last
  end

  def final_pick(collection)
    collection.sample
  end
end
