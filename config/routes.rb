Publinator::Engine.routes.draw do
  
  
  root :to => "home#index"

  match '/'	=> 'home#index'
  
  namespace :manage do
    match "/" => 'manage#index'
    constraints(Publinator::PublishableType) do
      match '/:publishable_type/new' => "publishable#new", :requirements => {
        :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
      }
      match '/:publishable_type/:id' => "publishable#show", :requirements => {
        :id => /\A\d*\z/i, 
        :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
      }
      match '/:publishable_type/' => "publishable#index" #, :requirements => {
      #   :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
      # }
    end
  end
  
  constraints(Publinator::PublishableType) do
    match '/:publishable_type/:id' => "publishable#show", :requirements => {
      :id => /\A\d*\z/i, 
      :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
    }
    match '/:publishable_type/' => "publishable#index" #, :requirements => {
    #   :publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i 
    # }
  end
  
  match "/:slug", :controller => :home, :action => :page, :requirements => { 
    :slug => /\A([a-zA-Z]+[a-zA-Z\-_]*)\z/i 
  }

end
