class Moment < ActiveRecord::Base
  belongs_to :gathering
  belongs_to :user
  has_many :votes, as: :votable
end
