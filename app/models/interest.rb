class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :gathering

  validates_uniqueness_of :user_id, :scope => [:gathering_id]
end
