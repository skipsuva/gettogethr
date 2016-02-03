class FinalizedPlan < ActiveRecord::Base
  belongs_to :gathering
  belongs_to :moment
  belongs_to :place
  belongs_to :activity

  validates :gathering, uniqueness: true
  validates :moment, uniqueness: true
  validates :place, uniqueness: true
  validates :activity, uniqueness: true
end
