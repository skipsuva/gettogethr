module Votable

  def upvotes
    self.votes.select do |vote|
      vote.value == 1
    end.count
  end

  def downvotes
    self.votes.select do |vote|
      vote.value == -1
    end.count
  end

  def shrugs
    self.votes.select do |vote|
      vote.value == 0
    end.count
  end

  # def vote_ratio(vote_type)
  #
  # end

end
