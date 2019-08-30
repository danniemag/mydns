Rails.application.routes.draw do
  resources :domains do
    collection do
      post '/uplist', to: 'domains#uplist'
    end
    resources :records
  end

  root to: 'domains#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
