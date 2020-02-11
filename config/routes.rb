Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  get '/shelters/:id', to: 'shelters#show'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets', to: 'pets#show_index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  patch '/favorite/:pet_id', to: 'favorite#update'
  delete '/favorite/:pet_id', to: 'favorite#destroy'
  delete '/favorites/:id', to: 'favorite#remove_favorite'

  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  delete '/reviews/:id', to: 'reviews#destroy'

  get '/favorites', to: 'favorite#index'
  get '/pets/:pet_id/applications', to: 'applications#index'
  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  patch '/applications/:application_id/pets/:pet_id', to: 'applications#update'
  patch '/applications/:application_id', to: 'applications#update'
  get '/applications/:id', to: 'applications#show'
end
