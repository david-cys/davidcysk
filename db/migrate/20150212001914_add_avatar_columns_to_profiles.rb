class AddAvatarColumnsToProfiles < ActiveRecord::Migration
  def self.up
    add_attachment :profiles, :avatar
  end

  def self.down
    add_attachment :profiles, :avatar
  end
end
