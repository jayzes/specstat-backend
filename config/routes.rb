Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :raw_test_run, only: [ :create ]
    end
  end
end
