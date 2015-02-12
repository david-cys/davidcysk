class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar, :styles => { :medium => "1024x1024>",
                                          :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/

end

