Publinator::Engine.routes.draw do
  
  
  root :to => "home#index"

  match '/'	=> 'home#index'
  
  namespace :manage do
    match "/" => 'manage#index'
    resources :sites
    constraints(Publinator::PublishableType) do
      match '/:publishable_type/' => "publishable#index", :requirements => {
        :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
        }, :as => "publishables"
      
      match '/:publishable_type/new' => "publishable#new", :requirements => {
        :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
      }
      
      match '/:publishable_type/create' => "publishable#create", :requirements => {
        :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
        }, :as => "create_publishable"
        
      match '/:publishable_type/:id/edit' => "publishable#edit", :requirements => {
          :id => /\A\d*\z/i, 
          :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
      }, :as => "edit_publishable"
      
      match '/:publishable_type/:id' => "publishable#show", :requirements => {
        :id => /\A\d*\z/i, 
        :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
        }, :as => "publishable"
    end
  end
  
  constraints(Publinator::PublishableType) do
    match '/:publishable_type/' => "publishable#index", :requirements => {
       :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
    }
    
    match '/:publishable_type/:id' => "publishable#show", :requirements => {
      :id => /\A\d*\z/i, 
      :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
      }, :as => "publishable"
    
  end
  
  match "/:slug", :controller => :home, :action => :page, :requirements => { 
    :slug => /\A([a-zA-Z]+[a-zA-Z\-_]*)\z/i 
  }

end
