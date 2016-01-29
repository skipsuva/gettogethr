class VotesController < ApplicationController

  def submit

    #TODO Sanitize input
    votable = Object.const_get(params[:votable_class]).find(params[:votable_id])
    gathering = Gathering.find(params[:gathering_id])

    if vote = Vote.find_by(user:current_user,votable:votable)
      if params[:thumbage].to_i == vote.value.to_i
        vote.destroy
      else
        vote.update(value:params[:thumbage])
      end
    else #vote doesn't exist
      new_vote = Vote.create(user: current_user, value: params[:thumbage])
      votable.votes << new_vote
    end

    redirect_to gathering

  end

  private

  # def new(user:user, value: value)
  #   new_vote = Vote.create(user: user, value: value)
  #   self.votes << new_vote
  # end
  #
  # def unvote(user)
  #   vote = Vote.find_by(user: user, votable: self)
  #   vote.destroy
  # end

end
