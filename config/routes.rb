Rails.application.routes.draw do
  root to: "public/homes#top"
  devise_scope :public do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end
  
  devise_for :users, controllers: {
  registrations: "public/registrations",
  passwords: 'public/passwords'
}


end
