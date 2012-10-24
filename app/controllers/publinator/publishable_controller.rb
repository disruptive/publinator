require_dependency "publinator/application_controller"

module Publinator
  class PublishableController < Publinator::ApplicationController
    def index
      @publication = Publinator::Publication.find_by_publishable_type_and_slug(params[:publishable_type].classify, 'index')
      @publishable_type = Publinator::PublishableType.find_by_name(params[:publishable_type].classify)
      if @publication
        @publishable = @publication.publishable
        begin
          render "#{params[:publishable_type]}/show"
        rescue ActionView::MissingTemplate
          render "publinator/publishable/show"
        end
      else
        @publishables = params[:publishable_type].classify.constantize.all
        begin
          render "#{params[:publishable_type]}/index"
        rescue ActionView::MissingTemplate
          render "publinator/publishable/index"
        end
      end
    end

    def show
      @publication = Publinator::Publication.find_by_publishable_type_and_slug(params[:publishable_type].classify, params[:id])
      @publishable = @publication.publishable
      @publishable_type = Publinator::PublishableType.find_by_name(params[:publishable_type].classify)
      begin
        render "#{params[:publishable_type]}/show"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    end
  end
end
