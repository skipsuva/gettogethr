class User < ActiveRecord::Base
  has_many :interests, dependent: :destroy
  has_many :gatherings, through: :interests

  has_many :own_gatherings, foreign_key: 'owner_id'

end
