module Api
  class AvatarsController < ApplicationController
    def show
      # avatars are always attached to profiles
      # not using active model serializer since avatar is not an AR class
      @profile = Profile.find_by(:token => params[:id])

      if @profile.blank? || !@profile.avatar?
        render :json => { :errors => "Avatar not found" }, :status => 404
      else
        case params[:size]
        when "thumb"
          render :json => { :thumb_url => @profile.avatar.url(:thumb) }
        when "medium"
          render :json => { :medium_url => @profile.avatar.url(:medium) }
        else
          render :json => { :medium_url => @profile.avatar.url(:medium),
                            :thumb_url => @profile.avatar.url(:thumb) }
        end
      end
    end
  end
end

