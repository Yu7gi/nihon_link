Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  #Top,Aboutルーティング設定
  root :to =>"homes#top"
  get "/about" => "homes#about", as: "about"

  #管理者側ルーティング設定
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end

  #会員側ルーティング設定
  scope module: :public do
    resources :users, only: [:show, :edit, :update, :destroy] do
      collection do
        get 'mypage'
      end
    end
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    resources :groups, only: [:index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      resource :permits, only: [:create, :destroy]
    end
    resources :messages, only: [:show, :index, :create, :destroy]
    resources :notifications, only: [:index, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    get "search" => "searches#search"
    get "genre/search" => "searches#genre_search"
    get "groups/:id/permits" => "groups#permits", as: :permits
  end

  #ゲストログイン設定
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
