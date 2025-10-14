Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
 
  resources :posts, only: [:index, :new, :create, :show, :destroy] # 追加
  resources :users, only: [:show]
end
