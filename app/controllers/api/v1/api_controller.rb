class Api::V1::ApiController < ApplicationController

  before_action :find_account

  respond_to :json

  private

  def find_account
    api_token = (request.headers['HTTP_AUTHORIZATION'] || '').gsub(/Bearer(\s*)/, '')
    unless @account = Account.where(api_token: api_token).first
      head :unauthorized
    end
  end

end
