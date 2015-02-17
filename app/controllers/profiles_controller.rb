class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :search]

  def new
    @profile = ProfileService.new_profile
  end

  def create
    @profile = ProfileService.
      new_profile(profile_params.merge!(:user => current_user))
    if @profile.save
      redirect_to profile_path(@profile),
        :notice => "Profile created successfully."
    else
      redirect_to new_profile_path(profile_params),
        :warning => "Something went wrong"
    end
  end

  def edit
    @profile = ProfileService.find(params[:id])
  end

  def update
    @profile = ProfileService.update(params[:id], profile_params)
    if @profile
      redirect_to profile_path(@profile),
        :notice => "Profile updated successfully."
    else
      redirect_to edit_profile_path(profile_params),
        :warning => "Something went wrong"
    end
  end

  def show
    @profile = ProfileService.find(params[:id])
  end

  def index
    @profiles = ProfileService.get_all_profiles
  end

  # ILIKE is postgres-specific
  def search
    @search_query = params[:query]
    @profiles = ProfileService.search_for(@search_query)
  end

  private
  def profile_params
    params.require(:profile).permit(:location, :tagline, :description,
                                    :user_id, :avatar, :name)
  end
end

