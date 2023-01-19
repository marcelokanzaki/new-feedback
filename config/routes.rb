Rails.application.routes.draw do
  devise_for :usuarios

  resources :usuarios, only: [:index] do
    get :impersonate, on: :member
    get :stop_impersonating, on: :collection
  end

  resources :ciclos, only: [:new, :create, :show, :edit, :update, :destroy] do
    patch :clonar, on: :member
    resources :equipes, only: [:new, :create, :show, :edit, :update, :destroy], shallow: true do
      resources :participacoes, only: [:new, :create, :show, :destroy], shallow: true
    end
  end

  resources :participacoes, only: [] do
    resources :feedbacks, only: [:new, :create], shallow: true do
      patch :aprovar, on: :member
    end
  end

  resources :notas, only: [:edit, :update]
  resource :meus_feedbacks, only: [:show]
  resource :minhas_equipes, only: [:show]

  root "home#show"
end
