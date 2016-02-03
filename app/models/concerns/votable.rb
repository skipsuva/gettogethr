module Votable

  def upvotes
    self.votes.reduce(0) do |memo, vote|
      if vote.value == 1
        memo + vote.value
      else
        memo
      end
    end
  end

  def downvotes

  end

end
