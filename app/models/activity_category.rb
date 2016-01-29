class ActivityCategory < ActiveRecord::Base
  has_many :activities

  validates :label, presence: true, uniqueness: { case_sensitive: false }
end
