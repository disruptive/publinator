Publinator::Engine.routes.draw do

  root :to  => "home#index"
  match '/' => 'home#index'

  namespace :manage do
    match "/" => 'manage#index'
    resources :sites
    resources :sections
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

  constraints(Publinator::Section) do
    match '/:section/' => "section#index", :requirements => {
       :section =>  /\A([a-zA-Z0-9]+[a-zA-Z0-9\-_]*)\z/i
    }

    match '/:section/:id' => "section#show", :requirements => {
      :id => /\A\d*\z/i,
      :section =>  /\A([a-zA-Z0-9]+[a-zA-Z0-9\-_]*)\z/i
      }, :as => "publishable"
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

  match "/:section/:slug", :controller => :sections, :action => :page, :requirements => {
    :section => /\A([a-zA-Z0-9]+[a-zA-Z0-9\-_]*)\z/i,
    :slug => /\A([a-zA-Z]+[a-zA-Z\-_]*)\z/i
  }


  match "/:slug", :controller => :home, :action => :page, :requirements => {
    :slug => /\A([a-zA-Z]+[a-zA-Z\-_]*)\z/i
  }

end
