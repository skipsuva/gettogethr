class Place < ActiveRecord::Base
  include Votable
  belongs_to :user
  belongs_to :gathering
  has_many :votes, as: :votable
  has_one :finalized_plan, dependent: :destroy
end
