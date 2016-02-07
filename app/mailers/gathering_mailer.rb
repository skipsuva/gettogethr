class GatheringMailer < ApplicationMailer

  def invite_user(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You have been invited to a gathering!)
end
