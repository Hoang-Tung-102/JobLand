Rails.application.routes.draw do
  namespace :employer do
    get 'bookmarks/index'
  end
  namespace :employer do
    get 'application/index'
  end
  namespace :employer do
    get 'payment/new'
  end
  resources :news
  resources :places
  devise_for :users,
                path: '',
                path_names: {sign_in: 'login' ,sign_out: 'logout' ,edit: 'profile',sign_up: 'resgistration'},
                controllers: {omniauth_callbacks: 'omniauth_callbacks' }
    as :user do
      get "signin", to: "devise/sessions#new"
      post "signin", to: "devise/sessions#create"
      delete "signout", to: "devise/sessions#destroy"
    end


    scope "(:locale)", locale: /en|vi/ do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    # mount Sidekiq::Web => "/sidekiq"

    get 'companies/show'
    mount Ckeditor::Engine => '/ckeditor'
    root to: 'static_pages#home'
    resources :jobs
    get 'users/new'
    get 'static_pages/home',to: "home#jobs"
    get '/home', to: 'static_pages#home'
    get '/contact', to: 'static_pages#contact'
    get '/all', to: 'static_pages#products'
    get 'search', to: 'search#index'
    namespace :admin do
      root "admin#index"
    end

    resources :jobs do
      resources :applyjobs, only: [:create, :destroy]
    end
    resources :jobs do
      resources :bookmarks, only: [:create, :destroy]
    end

    resources :jobs
    resources :cvs
    resources :companies, only: [:show]
    resources :profiles
    resources :experiences
    resources :rooms
    resources :companies do
      resources :jobs, only: [:index]
    end
    resources :educations
    resources :users do
      resources :applyjobs

    end

    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]

    resources :users do

      resources :bookmarks
    end

    resources :experiences
    resources :cv_skills
    resources :cv_languages
    namespace :employer do
      resources :jobs do
        resources :applyjobs
      end
      resources :jobs do
        resources :bookmarks
      end
      resources :profiles
      resources :webhooks
      resources :bookmarks, only: [:index]
      resources :companies
      resources :payments
      resources :applications, only: [:index]
      resources :members
      resources :users
      resources :portal_sessions, only: [:create]

    end
    resources :portfolios
    resources :search do
      collection do
        get :autocomplete
      end
    end
  end
end


