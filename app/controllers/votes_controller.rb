class VotesController < ApplicationController

  def submit

    #TODO Sanitize input
    votable = Object.const_get(params[:votable_class]).find(params[:votable_id])
    gathering = Gathering.find(params[:gathering_id])
    binding.pry

    #  case vote = Vote.find_by(user:current_user,votable:votable)
     #
    #  when #vote exists
    # when params[:thumbage]
    #   case #value is the same
    #     #delete vote
    #   case #value is different
    #     #change value of vote
    #   end
    # when #vote doesn't exist
    #   # create new vote with value
    # end

  end

  private

  def new(user:user, value: value)
    new_vote = Vote.create(user: user, value: value)
    self.votes << new_vote
  end

  def unvote(user)
    vote = Vote.find_by(user: user, votable: self)
    vote.destroy
  end

end
