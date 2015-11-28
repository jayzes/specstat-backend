class TestResult < ActiveRecord::Base

  # This is backed by a view, so it cannot be updated
  def readonly?
    true
  end

  def self.slowest
    select('name, AVG(runtime) AS average_runtime').
      where(status: 'passed').
      group(:name).
      order('average_runtime DESC')
  end

  def self.by_failure_count
    select("name, COUNT(CASE WHEN status = 'failed' THEN 1 ELSE NULL END) AS failure_count").
      group('name').
      order('failure_count DESC')
  end

end
