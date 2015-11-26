class Api::V1::RawTestRunsController < ApplicationController

  before_action :find_account

  respond_to :json

  def create
    @raw_test_run = @account.raw_test_runs.build(payload: JSON.parse(request.body.read))
    if @raw_test_run.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def find_account
    api_token = (request.headers['HTTP_AUTHORIZATION'] || '').gsub(/Bearer(\s*)/, '')
    unless @account = Account.where(api_token: api_token).first
      head :unauthorized
    end
  end


end
