class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :interests, dependent: :destroy
  has_many :gatherings, through: :interests
  has_many :moments
  has_many :places
  has_many :activities
  has_many :comments

  has_many :own_gatherings, foreign_key: 'owner_id'
  has_many :votes

  # has_secure_password
end
