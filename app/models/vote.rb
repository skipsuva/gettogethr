class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :votable_id, :scope => [:votable_type, :user_id]

end
