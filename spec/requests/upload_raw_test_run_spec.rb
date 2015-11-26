require "rails_helper"

RSpec.describe "Uploading a raw test run for processing", type: :request do

  describe "with a valid account" do
    let(:account) { Account.create!(name: "Test Account") }

    it "stores a RawTestRun model for later processing" do
      body = "[{\"name\":\"Specstat::Reporter has a version number\",\"status\":\"passed\",\"run_time\":1.23}]"
      post "/api/v1/raw_test_run", body, { "CONTENT_TYPE" => "application/json",
                                          "AUTHORIZATION" => "Bearer #{account.api_token}" }

      expect(account.raw_test_runs.count).to eq(1)
      expect(account.raw_test_runs.last.payload).to eq(JSON.parse(body))
    end
  end

  describe "with an invalid key" do
    it "stores a RawTestRun model for later processing" do
      body = "[{\"name\":\"Specstat::Reporter has a version number\",\"status\":\"passed\",\"run_time\":1.23}]"
      post "/api/v1/raw_test_run", body, { "CONTENT_TYPE" => "application/json",
                                          "AUTHORIZATION" => "Bearer abc123" }

      expect(response).to be_unauthorized
    end
  end

  describe "with no supplied credentials" do
    it "responds with a 401" do
      body = "[{\"name\":\"Specstat::Reporter has a version number\",\"status\":\"passed\",\"run_time\":1.23}]"
      post "/api/v1/raw_test_run", body, { "CONTENT_TYPE" => "application/json" }
      expect(response).to be_unauthorized
    end
  end

end
