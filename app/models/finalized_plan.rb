class FinalizedPlan < ActiveRecord::Base
  belongs_to :gathering
  belongs_to :moment
  belongs_to :place
  belongs_to :activity
end
