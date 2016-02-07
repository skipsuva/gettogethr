class GatheringMailer < ApplicationMailer

  def invite_user(user, gathering, current_user)
    @user = user
    @gathering = gathering
    @current_user = current_user
    # @url = gathering
    mail(to: @user.email, subject: 'You have been invited to a gathering!')
  end

  def finalize_plan(gathering, current_user)
    @gathering = gathering
    @current_user = current_user

    default to: Proc.new { @gathering.users.pluck(:email) },
          from: 'notification@example.com'

    mail(subject: "The gathering #{@gathering.title} has been finalized!")
  end

end
