class Activity < ActiveRecord::Base
  belongs_to :activity_category
  belongs_to :gathering
  belongs_to :user
  has_many :votes, as: :votable

  validates :description, presence: true
end
