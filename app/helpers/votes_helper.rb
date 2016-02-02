module VotesHelper
  def vote_count(votable,thumbage)
    votable.votes.count{|vote| vote.value == thumbage}
  end
end
