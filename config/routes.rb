Rails.application.routes.draw do
  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  devise_scope :public do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  devise_for :users, controllers: {
  registrations: "public/registrations",
  passwords: 'public/passwords'
}

  scope module: :public do
    get 'users/my_page' => 'users#show'
    get 'users/infomation/edit' => 'users#edit'
    patch 'users/infomation' => 'users#update'
    get 'users/confirm' => 'users#confirm'
    patch 'users/destroy' => 'users#destroy'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:index,:create, :destroy]
  end

  devise_for :admins, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get '/' => 'homes#top'

    resources :posts, only: [:index, :show, :edit, :update]
    resources :tags, only: [:create, :index, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]

  end


end
