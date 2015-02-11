class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user

      t.text :location
      t.text :tagline
      t.text :description

      t.timestamps
    end
  end
end
