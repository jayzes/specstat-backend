class Account < ActiveRecord::Base

  has_many :raw_test_runs, dependent: :destroy

  before_create :generate_api_token

  def generate_api_token
    self.api_token = SecureRandom.hex(32)
  end
end
