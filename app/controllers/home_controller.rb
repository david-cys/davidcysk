class HomeController < ApplicationController
  def index
    @profile = Profile.last
    @random_profile = Profile.get_random(@profile)
  end
end

