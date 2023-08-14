Rails.application.routes.draw do
  get 'games/new'
  post 'games/score'
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

# Rails.application.routes.draw do
#   get 'new', to: 'games#new'
#   post 'score', to: 'games#score'
# end
