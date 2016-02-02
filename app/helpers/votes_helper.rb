module VotesHelper
  def vote_count(votable,thumbage)
    votable.votes.to_a.count{|vote| vote.value == thumbage}
  end
end
