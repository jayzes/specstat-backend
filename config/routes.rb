Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :raw_test_run, only: [ :create ]
      get "stats/most_failing", to: "stats#most_failing"
      get "stats/slowest", to: "stats#slowest"
    end
  end
end
