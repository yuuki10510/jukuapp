Rails.application.routes.draw do
  #get "users/sign_up/select", to: "users/registrations#select_role", as: :select_role
  get "announcements/index"
  get "announcements/show"
  get "scores/index"
  devise_for :users, controllers: { registrations: "users/registrations" }

  root "dashboards#home"

  namespace :admin do
    get "withdrawals/new"
    get "withdrawals/create"
    get "announcements/index"
    get "announcements/new"
    get "announcements/create"
    get "announcements/edit"
    get "announcements/update"
    get "announcements/destroy"
    get "scores/new"
    get "scores/create"
    get "scores/edit"
    get "scores/update"
    get "students/index"
    get "students/show"
    resources :students do
      resources :scores
      resource :withdrawal, only: [:new, :create]
    end
    resources :announcements
  end

  resources :announcements, only: [:index, :show]
  resources :scores, only: [:index]

  get "dashboard", to: "dashboards#home"
end
