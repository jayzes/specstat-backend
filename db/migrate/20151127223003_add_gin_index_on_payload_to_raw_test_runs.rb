class AddGinIndexOnPayloadToRawTestRuns < ActiveRecord::Migration
  def change
    add_index :raw_test_runs, :payload, using: :gin
  end
end
