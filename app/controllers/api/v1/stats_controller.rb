class Api::V1::StatsController < Api::V1::ApiController

  def slowest
    render json: @account.test_results.slowest
  end

  def most_failing
    render json: @account.test_results.by_failure_count
  end

end
