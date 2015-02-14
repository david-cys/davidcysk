class Profile < ActiveRecord::Base
  self.primary_key = :token
  default_scope { order('created_at ASC') }

  belongs_to :user

  # these convert options will resize the image to a square and
  # set the background to white
  has_attached_file :avatar,
    :styles => { :medium => "1024x1024>", :thumb => "100x100>" },
    :convert_options => { :medium => "-gravity center -extent 1024x1024",
                          :thumb => "-gravity center -extent 100x100" }

  after_initialize :set_token

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/
  validates_uniqueness_of :token
  validates_presence_of :user

  def display_name
    name || user.email
  end

  def generate_token
    loop do
      random_token = SecureRandom.urlsafe_base64(6)
      break random_token unless Profile.exists?(token: random_token)
    end
  end

  def set_token
    self.token = generate_token if self.token.nil?
  end

  def self.get_random(excluded_profile)
    # this is postgres specific
    Profile.where.not(:token => excluded_profile).order("RANDOM()").last
  end
end

