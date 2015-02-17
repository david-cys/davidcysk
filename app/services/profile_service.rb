class ProfileService
  if Rails.env.production?
    @@base_uri = 'http://localhost/'
  else
    @@base_uri = 'http://localhost:3000/'
  end
  @@headers  = {:accept => "application/json",
                :content_type => "application/json"}

  def self.find(id)
    Profile.find(id)
  end

  def self.update(profile, options = {})
    profile = Profile.find(profile)
    profile.update(options)
    profile
  end

  def self.new_profile(options = {})
    Profile.new(options)
  end

  def self.get_all_profiles
    Profile.all.order(:created_at)
  end

  def self.get_last_updated
    # Profile.order(:created_at).last
    raw_response = RestClient.
      get("#{@@base_uri}api/profiles?get_last_updated=true", @@headers)
    p JSON.parse(raw_response)
    # have to return a profile object and not a hash
    # is there a better way to do this?
    hash = JSON.parse(raw_response)["users"]
    user = User.new(:email => hash.delete("email"))
    profile = Profile.new(hash)
    profile.user = user
    profile
  end

  def self.get_random_with_token(profile_token)
    Profile.get_random(profile_token)
  end

  def self.search_for(query)
    Profile.where("location ILIKE :query OR tagline ILIKE :query OR description ILIKE :query OR name ILIKE :query",
                  { :query => "%#{query}%" })
  end
end

