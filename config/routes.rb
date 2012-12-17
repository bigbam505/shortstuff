Shortstuff::Application.routes.draw do
  resources :short_urls, only: [:new, :create, :show]
  root to: "short_urls#new"

  match '/:name' => 'short_urls#show'
end
