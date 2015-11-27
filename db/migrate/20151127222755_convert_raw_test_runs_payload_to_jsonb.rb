class ConvertRawTestRunsPayloadToJsonb < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE raw_test_runs ALTER COLUMN payload SET DATA TYPE jsonb USING payload::jsonb;'
  end

  def down
    execute 'ALTER TABLE raw_test_runs ALTER COLUMN payload SET DATA TYPE json USING payload::json;'
  end
end
