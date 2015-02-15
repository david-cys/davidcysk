module Api
  class ProfilesController < ApplicationController
    def show
      # if using find instead of find_by, we have to catch the
      # ActiveRecord::RecordNotFound errror
      # we also only want to accept tokens and not numeric ids
      @profile = Profile.find_by(:token => params[:id])
      if @profile
        render :json => @profile, :root => "user"
      else
        render :json => { :errors => "Profile not found" }, :status => 404
      end
    end

    def update
      @profile = Profile.find_by(:token => params[:id])
      if @profile.blank?
        render :json => { :errors => "Profile not found" }, :status => 404
      elsif @profile.update(profile_params)
        render :json => {}, :status => 200
      else
        render :json => { :errors => "Something went wrong" }, :status => 404
      end
    end

    private
    def profile_params
      params.permit(:location, :tagline, :description, :avatar, :name)
    end
  end
end

