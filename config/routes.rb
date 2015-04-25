Rails.application.routes.draw do
  resources :quote_notes

  resources :backgrounds
  post 'add_background_and_redirect_to_quotenote', :to => 'backgrounds#add_and_redirect_to_quotenote'

  resources :products do
    resources :quote_notes, :only => [:show], :controller => 'products/quote_notes'
  end
  resources :orders, :only => [:create, :index, :show] do
    member do
      get :new_payment
      post :pay
    end
    post :retry_print_api_call
  end

  resource :cart, :only => :show do
    post 'add', :on => :member
    delete 'empty', :on => :member
    get 'checkout'
  end

  devise_for :users

  root :to => 'home#index'
  get 'generator' => 'generator#generate'
end
