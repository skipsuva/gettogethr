class Activity < ActiveRecord::Base
  belongs_to :activity_category
  belongs_to :gathering
end
