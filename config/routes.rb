Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  root "dashboards#home"

  # 保護者・生徒 共通画面
  resource :dashboard, only: [:show]
  resources :scores, only: [:index]
  resources :announcements, only: [:index, :show]
  resource :profile, only: [:show, :edit, :update]

  # 管理者専用画面
  namespace :admin do
    resources :students do
      resources :scores
      resource :withdrawal, only: [:new, :create]
    end
    resources :announcements
    resources :parent_students, only: [:new, :create, :destroy]
  end
end
