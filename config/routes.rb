Rails.application.routes.draw do
  root 'contacts#index'

  resources :contacts do
    patch 'share', on: :member
  end
end
