require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'automatically generates an api token when creating an account' do
    a = Account.create!(name: 'Test Account')
    expect(a.api_token).to be_present
  end
end
