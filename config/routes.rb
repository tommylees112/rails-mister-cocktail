Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"

  root to: "cocktails#home"

  resources :cocktails, only: [:index, :show, :new, :create, :destroy] do
    resources :doses, only: [:new, :create]
  end

  resources :doses, only: [:destroy]
end
