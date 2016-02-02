class VotesController < ApplicationController
  before_action -> { check_gathering_access(params['gathering_id'])}
  

  def submit

    #TODO Sanitize input
    @votable = Object.const_get(params[:votable_class]).find(params[:votable_id])
    gathering = Gathering.find(params[:gathering_id])
    @vote = Vote.find_by(user: current_user,votable: @votable)
    thumbage = params[:thumbage]

    if @vote
      update_thumbage(thumbage, @vote)
    else
      new_vote(thumbage, current_user, @votable)
    end

    respond_to do |format|
      format.html { redirect_to gathering }
      format.js {
        # new_vote is easy; update needs old vote value also
      }
    end
  end

  private

  def update_thumbage(thumbage, vote)
    if thumbage.to_i == vote.value.to_i
      vote.destroy
    else
      vote.update(value: thumbage)
    end
  end

  def new_vote(thumbage, user, votable)
    new_vote = Vote.create(user: user, value: thumbage)
    votable.votes << new_vote
  end

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
