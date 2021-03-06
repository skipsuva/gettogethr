class Gathering < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :interests, dependent: :destroy
  has_many :users, through: :interests
  has_many :moments, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :finalized_plan, dependent: :destroy

  #====================
  include AASM

  aasm do
    state :draft
    state :open, initial: true
    state :finalized
    state :closed
    state :cancelled

    event :finalize do
      transitions from: :open, to: :finalized
      #   guard do
      #     !has_finalized_plan?
      #   end
      # end
    end

    event :unfinalize do
      transitions from: :finalized, to: :open
      before do
        self.finalized_plan.try(:destroy)
      end
    end

    event :cancel do
      transitions from: :open, to: :cancelled
      transitions from: :finalized, to: :cancelled
    end

    event :to_draft do
      transitions from: :open, to: :draft
      transitions from: :cancelled, to: :draft
    end

    event :open do
      transitions from: :cancelled, to: :open
      transitions from: :draft, to: :open
    end

    event :close do
      transitions from: :finalized, to: :closed
    end

  end


  def has_finalized_plan?
    self.finalized_plan
  end

  # def finalized_plan_not_empty?
  #   fp = self.finalized_plan
  #   if fp
  #     return true if fp.moment
  #     return true if fp.place
  #     return true if fp.activity
  #   end
  #   false
  # end

  #====================

  def finalize_with_plan(moment:moment,place:place,activity:activity)
    FinalizedPlan.new(moment:moment,place:place,activity:activity)
  end

  # def save_finalized_plan(*args)
  #   fp = finalize_with_plan(*args)
  #   binding.pry
  #   self.finalized_plan = fp
  #   if !self.finalized_plan || !finalized_plan_not_empty?
  #     self.unfinalize
  #   end
  # end

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

  # def finalize_with_args(*args)
  #   self.finalize(:finalized, *args)
  # end

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
