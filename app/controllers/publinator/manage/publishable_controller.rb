require_dependency "publinator/application_controller"

module Publinator
  class Manage::PublishableController < ApplicationController
    layout "publinator/manage"
    
    def index
      @publishables = current_site.publications('published', 'updated_at desc', params["publishable_type"].singularize.capitalize)
      begin
        render "#{params[:publishable_type]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/index"
      end
    end
    
    def show
      @publication = Publinator::Publication.find_by_publishable_type_and_publishable_id(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = @publication.publishable
      begin
        render "#{params[:publishable_type]}/show"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/show"
      end
    end
    
    def new
      @publication = Publinator::Publication.find_by_publishable_type_and_publishable_id(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = params['publishable_type'].singularize.capitalize.constantize.new
      begin
        render "#{params[:publishable_type]}/new"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/new"
      end
    end
  end
end
