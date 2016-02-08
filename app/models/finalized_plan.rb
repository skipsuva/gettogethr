class FinalizedPlan < ActiveRecord::Base
  belongs_to :gathering
  belongs_to :moment
  belongs_to :place
  belongs_to :activity

  validates :gathering, uniqueness: true, scope: [:moment_id, :place_id, :activity_id]
end
