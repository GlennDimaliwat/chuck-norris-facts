require 'rails_helper'

RSpec.describe "Facts", type: :request do
  describe "GET /facts" do
    it "works! (now write some real specs)" do
      get facts_path
      expect(response).to have_http_status(200)
    end
  end
end
