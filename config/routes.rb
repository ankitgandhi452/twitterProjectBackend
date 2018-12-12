Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :tweets do
    collection do
      get '/search/:search', to: 'tweets#search', as: :tweet_search
    end 
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
