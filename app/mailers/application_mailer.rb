class ApplicationMailer < ActionMailer::Base
  default from: "administrator@gettogethr.herokuapp.com"
  layout 'mailer'
end
