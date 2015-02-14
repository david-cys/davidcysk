class AddTokenToProfiles < ActiveRecord::Migration
  def up
    add_column :profiles, :token, :string
    Profile.reset_column_information
    Profile.order(created_at: :asc).each do |profile|
      profile.set_token
      profile.save!
    end
    change_column :profiles, :token, :string, :null => false

    add_index :profiles, :token, :unique => true
  end

  def down
    remove_column :profiles, :token
  end
end
