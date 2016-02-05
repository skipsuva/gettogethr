module VotesHelper
  def vote_count(votable,thumbage)
    votable.votes.to_a.count{|vote| vote.value == thumbage}
  end

  def vote(votable,user)
    (user.votes & votable.votes).try(:first)
  end

  def class_mapping(thumbage)
    hash = {1 => "thumbs-up", 0 => "shruggie", -1 => "thumbs-down"}
    hash[thumbage.to_i]
  end

  def icon_mapping(thumbage)
    hash = {1 => "fa-thumbs-up", 0 => "fa-question-circle", -1 => "fa-thumbs-down"}
    hash[thumbage.to_i]
  end

end
