class HomeController < ApplicationController
  def index
    @profile = ProfileService.get_last_updated
    @random_profile = ProfileService.get_random_token(@profile)
  end
end

