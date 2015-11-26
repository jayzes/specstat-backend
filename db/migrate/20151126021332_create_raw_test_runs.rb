class CreateRawTestRuns < ActiveRecord::Migration
  def change
    create_table :raw_test_runs do |t|
      t.json :payload
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
