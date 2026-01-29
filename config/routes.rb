Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    get "users/sign_up/select_role", to: "users/registrations#select_role", as: :select_role
    post "users/guest_admin_sign_in", to: "users/sessions#guest_admin_sign_in"
    post "users/guest_parent_sign_in", to: "users/sessions#guest_parent_sign_in"

    # 管理者専用ログイン
    get    "admin/login",  to: "admin/sessions#new",     as: :admin_login
    post   "admin/login",  to: "admin/sessions#create", as: :admin_login_post
    delete "admin/logout", to: "admin/sessions#destroy", as: :admin_logout
    post   "admin/guest_login", to: "admin/sessions#guest_login", as: :admin_guest_login
  end

  root "dashboards#home"

  # 保護者・生徒 共通画面
  resource :dashboard, only: [:show]
  resources :scores, only: [:index]
  resources :announcements, only: [:index, :show]
  resource :profile, only: [:show, :edit, :update]

  # 管理者専用画面
  namespace :admin do
    root to: "dashboard#index"

    resources :students do
      get  "scores/edit_test",
           to: "scores#edit_test",
           as: :edit_test_scores

      patch "scores/update_test",
            to: "scores#update_test",
            as: :update_test_scores

      resource :withdrawal, only: [:new, :create]
    end

    resources :parents, only: [:index]
    resources :announcements
    resources :parent_students, only: [:new, :create, :destroy]
  end
end
