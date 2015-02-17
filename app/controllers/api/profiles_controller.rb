module Api
  class ProfilesController < ApplicationController
    def index
      if params.has_key?(:get_last_updated)
        @profiles = Profile.order(:created_at).last
      else
        @profiles = Profile.order(:created_at)
      end

      if @profiles
        render :json => @profiles, :root => "users"
      else
        render :json => { :errors => "Profile not found" }, :status => 404
      end
    end

    def show
      # if using find instead of find_by, we have to catch the
      # ActiveRecord::RecordNotFound errror
      # we also only want to accept tokens and not numeric ids
      if params.has_key?(:get_last_updated)
        @profile = Profile.order(:created_at).last
      else
        @profile = Profile.find_by(:token => params[:id])
      end

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

