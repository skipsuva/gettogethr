class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :interests, dependent: :destroy
  has_many :gatherings, through: :interests
  has_many :moments
  has_many :places
  has_many :activities
  has_many :comments

  has_many :own_gatherings, foreign_key: 'owner_id', class_name:'Gathering'
  has_many :votes

  def notified(gathering)
    Interest.find_by(gathering:gathering,user:self).try(:notified_at)
  end

  def notified_recently?(gathering)
    notified = notified(gathering)
    if !notified
      return false
    else
      if (Time.now - notified) > 86400
        return false
      else
        return true
      end
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
end
