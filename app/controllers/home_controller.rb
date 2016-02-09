class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'application'

  def letsencrypt
    render text: ENV["LE-CHALLENGE"]
  end
end
