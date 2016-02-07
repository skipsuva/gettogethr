class GatheringMailer < ApplicationMailer

  def invite_user(user, gathering)
    @user = user
    @gathering = gathering
    @current_user = current_user
    # @url = gathering
    mail(to: @user.email, subject: 'You have been invited to a gathering!')
  end
end
