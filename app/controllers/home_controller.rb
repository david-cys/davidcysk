class HomeController < ApplicationController
  def index
    @profile = Profile.last
  end
end

