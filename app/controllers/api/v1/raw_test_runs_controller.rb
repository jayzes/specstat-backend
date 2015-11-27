class Api::V1::RawTestRunsController < Api::V1::ApiController

  def create
    @raw_test_run = @account.raw_test_runs.build(payload: JSON.parse(request.body.read))
    if @raw_test_run.save
      head :created
    else
      head :unprocessable_entity
    end
  end

end
