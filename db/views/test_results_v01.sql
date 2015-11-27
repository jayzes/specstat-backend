WITH raw_results AS (
  SELECT
    jsonb_array_elements(payload) AS result,
    account_id,
    created_at,
    updated_at
  FROM raw_test_runs
)
SELECT
  result->>'name' AS name,
  result->>'status' AS status,
  (result->>'run_time')::float AS runtime,
  account_id,
  created_at,
  updated_at
FROM raw_results
