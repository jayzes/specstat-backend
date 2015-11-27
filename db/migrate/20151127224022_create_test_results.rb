class CreateTestResults < ActiveRecord::Migration
  def change
    create_view :test_results
  end
end
