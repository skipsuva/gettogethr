class GatheringMailer < ApplicationMailer

  def invite_user(user, gathering, current_user)
    @user = user
    @gathering = gathering
    @current_user = current_user
    # @url = gathering
    mail(to: @user.email, subject: 'You have been invited to a gathering!')
  end

  def finalize_plan(gathering, user, current_user)
    @gathering = gathering
    @current_user = current_user
    @user = user

    mail(to: @user.email, subject: "The gathering #{@gathering.title} has been finalized!")
  end

end
