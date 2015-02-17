class HomeController < ApplicationController
  def index
    @profile = ProfileService.get_last_updated
    @random_profile = ProfileService.get_random_with_token(@profile.token)
  end
end

