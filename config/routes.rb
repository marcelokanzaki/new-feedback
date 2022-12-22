Rails.application.routes.draw do
  devise_for :usuarios

  resources :ciclos, only: [:show] do
    resources :equipes, only: [:show]
    resources :participacoes, only: [:show]
  end

  resources :participacoes, only: [] do
    resources :feedbacks, only: [:new, :create]
  end

  resources :avaliacoes

  resource :meus_feedbacks, only: [:show]

  root "home#show"
end
