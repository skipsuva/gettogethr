class HomeController < ApplicationController
  skip_before_action :authenticate!
  layout 'home'
end
