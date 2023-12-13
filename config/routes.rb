Rails.application.routes.draw do
  root "books#index"

  resources :books do
    collection do
      get :search
    end
  end

  devise_for :users, skip: [:passwords, :sessions, :registrations]

    devise_scope :user do
      get 'users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
      post 'users', to: 'devise/registrations#create', as: :user_registration
      get 'users/sign_in', to: 'devise/sessions#new', as: :new_user_session
      post 'users/sign_in', to: 'devise/sessions#create', as: :user_session
      delete 'users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    end
end
