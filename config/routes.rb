Rails.application.routes.draw do
  root 'facts#index'
  
  get '/facts/top10' => 'facts#top_10'
  
  resources :facts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
