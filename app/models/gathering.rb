class Gathering < ActiveRecord::Base
  belongs_to :owner
  has_many :interests, dependent: :destroy
  has_many :users, through: :interests
end
