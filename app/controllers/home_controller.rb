class HomeController < ApplicationController
  def index
    @user = User.last
  end
end

