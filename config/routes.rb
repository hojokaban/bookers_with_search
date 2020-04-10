Rails.application.routes.draw do
	root 'books#home'
	get 'home/about' => 'books#about', as: 'about_book'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
end
