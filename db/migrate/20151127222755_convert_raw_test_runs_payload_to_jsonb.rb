class ConvertRawTestRunsPayloadToJsonb < ActiveRecord::Migration
  def up
    execute <<-EOF
      ALTER TABLE raw_test_runs
        ALTER COLUMN payload
        SET DATA TYPE jsonb
        USING payload::jsonb;
      EOF
  end

  def down
    execute <<-EOF
      ALTER TABLE raw_test_runs
        ALTER COLUMN payload
        SET DATA TYPE json
        USING payload::json;
      EOF
  end
end
