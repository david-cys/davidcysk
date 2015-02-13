class Profile < ActiveRecord::Base
  belongs_to :user

  # these convert options will resize the image to a square and
  # set the background to white
  has_attached_file :avatar,
    :styles => { :medium => "1024x1024>", :thumb => "100x100>" },
    :convert_options => { :medium => "-gravity center -extent 1024x1024",
                          :thumb => "-gravity center -extent 100x100" }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/

  def display_name
    name || user.email
  end

  def self.get_random(excluded_profile)
    # this is postgres specific
    Profile.where.not(:id => excluded_profile).order("RANDOM()").last
  end
end

