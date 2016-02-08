module VotesHelper
  def vote_count(votable,thumbage)
    votable.votes.to_a.count{|vote| vote.value == thumbage}
  end

  def vote(votable,user)
    #TODO make into single SQL query for better performance
    (user.votes & votable.votes).try(:first)
  end

  def current_vote(votable)
    vote(votable,current_user)
  end

  def voted_class
    'btn-success'
  end

  def class_mapping(thumbage)
    hash = {1 => "thumbs-up", 0 => "shruggie", -1 => "thumbs-down"}
    hash[thumbage.to_i]
  end

  def icon_mapping(thumbage)
    hash = {1 => "fa-thumbs-up", 0 => "fa-question-circle", -1 => "fa-thumbs-down"}
    hash[thumbage.to_i]
  end

  def users_for_votable_vote(votable, thumbage)
    votable.votes.joins(:user).where(value: thumbage).map {|v| v.user.name}
  end
end
