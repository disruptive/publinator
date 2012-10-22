require_dependency "publinator/application_controller"

module Publinator
  class PublishableController < Publinator::ApplicationController
    def index
      @publication = Publinator::Publication.find_by_publishable_type_and_slug(params[:publishable_type].singularize.capitalize, 'index')
      if @publication.nil?
        logger.info "looking for publication with slug #{params[:publishable_type]}"
        @publication = Publinator::Publication.find_by_slug(params[:publishable_type])
        @publishable = @publication.publishable
        logger.info @publication.to_yaml
        begin
          render "#{params[:publishable_type]}/show"
        rescue ActionView::MissingTemplate
          render "publinator/publishable/show"
        end
      else
        @publishables = current_site.publications('published', 'updated_at desc', params["publishable_type"].singularize.capitalize)
        begin
          render "#{params[:publishable_type]}/index"
        rescue ActionView::MissingTemplate
          render "publinator/publishable/index"
        end
      end
    end

    def show
      @publication = Publinator::Publication.find_by_publishable_type_and_slug(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = @publication.publishable
      begin
        render "#{params[:publishable_type]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    end
  end
end
