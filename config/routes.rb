Rails.application.routes.draw do
  devise_for :usuarios

  resources :usuarios, only: [:index] do
    get :impersonate, on: :member
    get :stop_impersonating, on: :collection
  end

  resources :ciclos, only: [:show] do
    resources :equipes, only: [:show]
    resources :participacoes, only: [:show]
  end

  resources :participacoes, only: [] do
    resources :feedbacks, only: [:new, :create]
  end

  resources :notas, only: [:edit, :update]

  resources :avaliacoes

  resource :meus_feedbacks, only: [:show]

  root "home#show"
end
