class Place < ActiveRecord::Base
  belongs_to :user
  belongs_to :gathering
  has_many :votes, as: :votable
end
