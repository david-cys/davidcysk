require 'spec_helper'

describe "API Avatars" do
  describe "GET /api/avatar/:id" do
    it "returns the s3 url" do
      profile1 = create(:profile_with_avatar)
      get "/api/avatars/#{profile1.token}", {},
        { "Accept" => "application/json" }

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body["medium_url"]).to eq(profile1.avatar.url(:medium))
      expect(body["thumb_url"]).to eq(profile1.avatar.url(:thumb))
    end

    it "returns a specific size if requested" do
      profile1 = create(:profile_with_avatar)
      get "/api/avatars/#{profile1.token}?size=thumb", {},
        { "Accept" => "application/json" }

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body["medium_url"]).to be_nil
      expect(body["thumb_url"]).to eq(profile1.avatar.url(:thumb))

      get "/api/avatars/#{profile1.token}?size=medium", {},
        { "Accept" => "application/json" }

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body["medium_url"]).to eq(profile1.avatar.url(:medium))
      expect(body["thumb_url"]).to be_nil
    end

    it "returns 404 if profile does not have an avatar" do
      profile1 = create(:profile)
      get "/api/avatars/#{profile1.token}", {},
        { "Accept" => "application/json" }

      expect(response.status).to eq(404)
    end

    it "returns 404 if profile not found" do
      get "/api/avatars/profiledoesnotexist", {},
        { "Accept" => "application/json" }

      expect(response.status).to eq(404)
    end
  end
end
