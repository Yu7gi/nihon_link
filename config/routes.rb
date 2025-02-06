Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  root :to =>"homes#top"
  get "/about" => "homes#about", as: "about"

  resources :users, only: [:show, :edit, :update, :destroy] do
    collection do
      get 'mypage'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
