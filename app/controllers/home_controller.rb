class HomeController < ApplicationController
  skip_before_action :authenticate!
  layout 'application'
end
