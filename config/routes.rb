Rails.application.routes.draw do
  resources :quote_notes

  resources :backgrounds
  resources :products do
    resources :quote_notes, :only => [:show], :controller => 'products/quote_notes'
  end

  resource :cart, :only => :show do
    post 'add', :on => :member
    get 'checkout'
  end

  devise_for :users

  root :to => 'quote_notes#new'
  get 'generator' => 'generator#generate'
end
