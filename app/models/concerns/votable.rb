module Votable

  def vote(user:user, value: value)
    new_vote = Vote.create(user: user, value: value)
    self.votes << new_vote
  end

  def unvote(user, value)

  end

end
