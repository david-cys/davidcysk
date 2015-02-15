module Api
  class ProfilesController < ApplicationController
    def show
      # if using find instead of find_by, we have to catch the
      # ActiveRecord::RecordNotFound errror
      # we also only want to accept tokens and not numeric ids
      @profile = Profile.find_by(:token => params[:id])
      if @profile
        render :json => @profile
      else
        render :json => { :errors => "Profile not found" },
          :status => :not_found
      end
    end
  end
end

