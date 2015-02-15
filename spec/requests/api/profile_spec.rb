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
      p body
      expect(body["user"]["id"]).to eq(profile1.token)
      expect(body["user"]["name"]).to eq(profile1.name)
      expect(body["user"]["email"]).to eq(profile1.user.email)
      expect(body["user"]["tagline"]).to eq(profile1.tagline)
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

