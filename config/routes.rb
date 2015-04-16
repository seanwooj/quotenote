Rails.application.routes.draw do
  resources :quote_notes

  resources :backgrounds
  resources :products do
    resources :quote_notes, :only => [:show], :controller => 'product/quote_notes'
  end

  devise_for :users

  root :to => 'quote_notes#new'
  get 'generator' => 'generator#generate'
end
