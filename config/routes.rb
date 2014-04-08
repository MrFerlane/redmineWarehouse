# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :projects do
  resources :merchandises
  get 'static_page', :to => 'test_static_pages#index'
end

