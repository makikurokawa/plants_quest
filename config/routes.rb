Rails.application.routes.draw do
  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#new_guest'
  end

  devise_for :users, controllers: {
  registrations: "public/registrations",
  passwords: 'public/passwords',
  sessions: "public/sessions"

}

  scope module: :public do
    get 'users/infomation/edit' => 'users#edit'
    patch 'users/infomation' => 'users#update'
    get 'users/confirm' => 'users#confirm'
    patch 'users/destroy' => 'users#destroy'
    resources :users, only: [:show]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end
  end

  devise_for :admins, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get '/' => 'homes#top'

    resources :posts, only: [:index, :show]
    resources :post_comments, only: [:index, :destroy]
    resources :users, only: [:index, :show, :edit, :update]

  end


end
