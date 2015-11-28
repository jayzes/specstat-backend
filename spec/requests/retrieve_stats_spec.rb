require "rails_helper"

RSpec.describe "Retrieving stats", type: :request do

  let(:account) { Account.create!(name: "Test Account") }

  before do
    account.raw_test_runs.create! payload: [
      { name: "Test 1", status: "passed", run_time: 1.1 },
      { name: "Test 2", status: "passed", run_time: 1.5 },
      { name: "Test 3", status: "passed", run_time: 2.5 },
      { name: "Test 4", status: "failed", run_time: 0.5 }
    ]
    account.raw_test_runs.create! payload: [
      { name: "Test 1", status: "passed", run_time: 1.1 },
      { name: "Test 2", status: "passed", run_time: 1.5 },
      { name: "Test 3", status: "failed", run_time: 0.5 },
      { name: "Test 4", status: "passed", run_time: 1.5 }
    ]
  end

  let(:json_body) { JSON.parse(response.body) }

  describe "Fetching the most frequently failing tests" do

    describe "with a valid account" do

      it "returns an array sorted by failure count" do
        get "/api/v1/stats/most_failing",
          {},
          { "ACCEPT" => "application/json",
            "AUTHORIZATION" => "Bearer #{account.api_token}" }
        expect(json_body).to eq([
          { "name" => "Test 3",
            "failure_count" => 1 },
          { "name" => "Test 4",
            "failure_count" => 1 },
          { "name" => "Test 2",
            "failure_count" => 0 },
          { "name" => "Test 1",
            "failure_count" => 0 }
        ])
      end
    end

    describe "with an invalid key" do
      it "responds with an unauthorized message" do
        get "/api/v1/stats/most_failing",
          {},
          { "ACCEPT" => "application/json",
            "AUTHORIZATION" => "Bearer abc123" }
        expect(response).to be_unauthorized
      end
    end

    describe "with no supplied credentials" do
      it "responds with a 401" do
        get "/api/v1/stats/most_failing",
          {},
          { "ACCEPT" => "application/json" }
        expect(response).to be_unauthorized
      end
    end
  end

  describe "Fetching the slowest average tests" do

    describe "with a valid account" do

      it "returns an array sorted by average runtime" do
        get "/api/v1/stats/slowest",
          {},
          { "ACCEPT" => "application/json",
            "AUTHORIZATION" => "Bearer #{account.api_token}" }
        expect(json_body).to eq([
          { "name" => "Test 3",
            "average_runtime" => 2.5 },
          { "name" => "Test 2",
            "average_runtime" => 1.5 },
          { "name" => "Test 4",
            "average_runtime" => 1.5 },
          { "name" => "Test 1",
            "average_runtime" => 1.1 }
        ])
      end
    end

    describe "with an invalid key" do
      it "responds with an unauthorized message" do
        get "/api/v1/stats/slowest",
          {},
          { "ACCEPT" => "application/json",
            "AUTHORIZATION" => "Bearer abc123" }
        expect(response).to be_unauthorized
      end
    end

    describe "with no supplied credentials" do
      it "responds with a 401" do
        get "/api/v1/stats/slowest",
          {},
          { "ACCEPT" => "application/json" }
        expect(response).to be_unauthorized
      end
    end
  end

end
