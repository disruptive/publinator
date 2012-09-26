require_dependency "publinator/application_controller"

module Publinator
  class Manage::SitesController < ApplicationController
    layout "publinator/manage"
    
    def index
      @sites = Publinator::Site.all
    end
    
    def new
      @site = Publinator::Site.new
    end
    
    def create
      @site = Publinator::Site.new(params[:site])
      if @site.save
        redirect_to :index, :notice => "Site created."
      else
        render :new
      end
    end
  end
end