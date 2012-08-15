require_dependency "publinator/application_controller"

module Publinator
  class PublishableController < ApplicationController
    def index
      @publishables = current_site.publications('published', 'updated_at desc', params["publishable_type"].singularize.capitalize)
      begin
        render "#{params[:publishable_type]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/index"
      end
    end
    
    def show
      @publication = Publinator::Publication.find_by_publishable_type_and_publishable_id(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = @publication.publishable
      begin
        render "#{params[:publishable_type]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    end
  end
end
