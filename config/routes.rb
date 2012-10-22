Publinator::Engine.routes.draw do

  match "/manage" => 'manage#index'

  namespace :manage do

    Publinator::PublishableType.all.each do |pt|
      resources pt.name.pluralize.downcase.to_sym, :controller => "publishable", :publishable_type => pt.name.pluralize.downcase
      #match "/#{pt.name.pluralize.downcase}" => "publishable#index", :as => pt.name.pluralize.downcase, :publishable_type => pt.name
    end

    #constraints(Publinator::PublishableType) do
      #match '/:publishable_type/' => "publishable#index", :requirements => {
        #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
        #}, :as => "publishables"

      #match '/:publishable_type/new' => "publishable#new", :requirements => {
        #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
      #}

      #match '/:publishable_type/create' => "publishable#create", :requirements => {
        #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
        #}, :as => "create_publishable"

      #match '/:publishable_type/:id/edit' => "publishable#edit", :requirements => {
          #:id => /\A\d*\z/i,
          #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
      #}, :as => "edit_publishable"

      #match '/:publishable_type/:id' => "publishable#show", :requirements => {
        #:id => /\A\d*\z/i,
        #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
        #}, :as => "publishable"
    #end

    resources :pages
    resources :sites
    resources :sections
    resources :publishable_types
  end

  #constraints(Publinator::PublishableType) do
    #match '/:publishable_type/' => "publishable#index", :requirements => {
       #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
    #}

    #match '/:publishable_type/:id' => "publishable#show", :requirements => {
      #:id => /\A\d*\z/i,
      #:publishable_type => /\A([a-zA-Z]+[a-zA-Z_]*)\z/i
      #}, :as => "publishable"
  #end
  #

  Publinator::PublishableType.all.each do |pt|
    resources pt.name.pluralize.downcase.to_sym, :controller => "publishable", :only => [:index, :show], :publishable_type => pt.name.pluralize.downcase
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

  match "/:slug", :controller => :home, :action => :page, :requirements => {
    :slug => /\A([a-zA-Z]+[a-zA-Z\-_]*)\z/i
  }, :as => 'publishable'

  root :to  => "home#index"
  match '/' => 'home#index'

end
