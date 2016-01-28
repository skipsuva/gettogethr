class User < ActiveRecord::Base
  has_many :interests, dependent: :destroy
  has_many :gatherings, through: :interests

  has_many :own_gatherings, foreign_key: 'owner_id'
  has_many :votes

  has_secure_password
end
