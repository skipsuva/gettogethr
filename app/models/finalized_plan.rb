class FinalizedPlan < ActiveRecord::Base
  belongs_to :gathering
  belongs_to :moment
  belongs_to :place
  belongs_to :activity

  validates_uniqueness_of :gathering, scope: [:moment_id, :place_id, :activity_id]
end
