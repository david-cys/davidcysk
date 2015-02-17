class ProfileService
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
    Profile.order(:created_at).last
  end

  def self.get_random_token(profile)
    Profile.get_random(profile)
  end

  def self.search_for(query)
    Profile.where("location ILIKE :query OR tagline ILIKE :query OR description ILIKE :query OR name ILIKE :query",
                  { :query => "%#{query}%" })
  end
end

