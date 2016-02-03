class Activity < ActiveRecord::Base
  include Votable
  belongs_to :activity_category
  belongs_to :gathering
  belongs_to :user
  has_many :votes, as: :votable
  has_one :finalized_plan

  validates :description, presence: true
end
