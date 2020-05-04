Rails.application.routes.draw do
	devise_for :users
	root 'books#home'
	get 'home/about' => 'books#about', as: 'about_book'
	post 'favorites/:book_id' => 'favorites#create', as: 'favorite'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
  resources :favorites, only: [:destroy]
end
