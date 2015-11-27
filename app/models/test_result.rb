class TestResult < ActiveRecord::Base

  # This is backed by a view, so it cannot be updated
  def readonly?
    true
  end

end
