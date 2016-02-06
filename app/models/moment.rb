class Moment < ActiveRecord::Base
  include Votable
  belongs_to :gathering
  belongs_to :user
  has_many :votes, as: :votable
  has_one :finalized_plan, dependent: :destroy

  validates_presence_of :time
end
