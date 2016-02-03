module Votable

  def upvotes
    self.votes.select do |vote|
      vote == 1
    end.count
  end

  def downvotes
    self.votes.select do |vote|
      vote == -1
    end.count
  end

  def shrugs
    self.votes.select do |vote|
      vote == 0
    end.count
  end

end
