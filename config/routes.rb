Rails.application.routes.draw do
  root 'contacts#index'

  resources :contacts do
    put 'share', on: :member
    post 'import', on: :collection
  end
end
