Rails.application.routes.draw do
	devise_for :users
	root 'books#home'
	get 'home/about' => 'books#about', as: 'about_book'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
end
