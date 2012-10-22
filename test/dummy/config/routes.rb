Rails.application.routes.draw do
  mount Publinator::Engine => "/"
  resources :widgets
end
