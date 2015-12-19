Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  root to: 'top#index'
  get '/parent' => 'top#parent'
  get '/student_user' => 'top#student_user'
  get '/support' => 'top#supporter'
  get '/about' => 'top#about'
  get '/corporate' => 'top#corporate'
  get '/privacy' => 'top#privacy'
  get '/terms' => 'top#terms'
  get '/legal' => 'top#legal'
  get '/contact' => 'top#contact'

  resources :users, only: [:show, :edit, :update]

  resources :tickets do
    collection do
      get 'search'
      get 'parchase'
    end
  end

  resources :supporters do
    collection do
      get 'search'
    end
  end

  resources :students do
    collection do
      get 'search'
    end
  end

  resources :diaries do
    collection do
      get 'search'
    end
  end

  resources :comments, only: [:create, :update, :destroy]

  resources :messages, except: [:edit, :update]
end
