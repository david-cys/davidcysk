class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :search]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile),
        :notice => "Profile created successfully."
    else
      redirect_to new_profile_path(profile_params),
        :warning => "Something went wrong"
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to profile_path(@profile),
        :notice => "Profile updated successfully."
    else
      redirect_to edit_profile_path(profile_params),
        :warning => "Something went wrong"
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def index
    @profiles = Profile.all.order(:created_at)
  end

  # ILIKE is postgres-specific
  def search
    @search_query = params[:query]
    @profiles = Profile.
      where("location ILIKE :query OR tagline ILIKE :query OR description ILIKE :query OR name ILIKE :query", { :query => "%#{params[:query]}%" })
  end

  private
  def profile_params
    params.require(:profile).permit(:location, :tagline, :description, :user_id,
                                    :avatar, :name)
  end
end

