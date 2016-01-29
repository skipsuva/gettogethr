class HomeController < ApplicationController
  def index
    redirect_to gatherings_url
  end
end
