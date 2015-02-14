require 'spec_helper'

describe Profile do
  it "should generate a token automatically" do
    user = create(:user)
    profile = Profile.create(:location => "test location", :user => user)
    expect(profile.token).to be_instance_of(String)
    expect(profile.token.length).to eq(8)
  end
end
