Rails.application.routes.draw do
	devise_for :users
	root 'books#home'
	get 'home/about' => 'books#about', as: 'about_book'
	post 'favorites/:id' => 'favorites#create', as: 'favorite'
	delete 'favorites/:id' => 'favorites#destroy', as: 'favorites'
	post 'comments' => 'book_comments#create', as: 'comment'
	delete 'comments/:id' => 'book_comments#destroy', as: 'comments'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
end
