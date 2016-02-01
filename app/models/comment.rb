class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :gathering

  validates :content, presence: true
end
