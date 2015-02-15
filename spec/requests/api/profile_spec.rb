require 'spec_helper'

describe "API Profiles" do
  describe "GET /api/profiles/:token" do
    it "returns the correct profile" do
      create(:profile)
      profile1 = create(:profile)
      create(:profile)
      get "/api/profiles/#{profile1.token}", {},
        { "Accept" => "application/json" }

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body["description"]).to eq(profile1.description)
    end

    it "returns 404 if profile not found" do
      create(:profile)
      get "/api/profiles/invalididhere", {},
        { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(body["errors"]).to eq("Profile not found")
    end
  end
end

