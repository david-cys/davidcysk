require 'spec_helper'

describe "API Profiles" do
  describe "GET /api/profiles/:token" do
    it "returns the correct profile" do
      profile1 = create(:profile)
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

  describe "POST /api/profiles/update" do
    it "updates the profile" do
      profile1 = create(:profile)
      post "/api/profiles/update",
        { :id => profile1.token,
          "tagline" => "update this tagline please",
          "location" => "update this location too",
          "description" => "don't forget this description" },
        { "Accept" => "application/json" }

      profile1.reload
      expect(response.status).to eq(200)
      expect(profile1.location).to eq("update this location too")
      expect(profile1.tagline).to eq("update this tagline please")
      expect(profile1.description).to eq("don't forget this description")
    end

    it "returns 404 if something went wrong" do
      profile1 = create(:profile)
      post "/api/profiles/update",
        { :id => "faketoken", "tagline" => "update this tagline please" },
        { "Accept" => "application/json" }

      body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(body["errors"]).to eq("Profile not found")
      profile1.reload
      expect(profile1.tagline).not_to eq("update this tagline please")
    end
  end

end

