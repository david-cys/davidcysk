require 'spec_helper'

describe HomeController do
  describe "GET #index" do
    it "responds successfully with HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
end

