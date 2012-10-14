require_dependency "publinator/application_controller"

module Publinator
  class HomeController < ApplicationController
    def index
      begin
        render "home/index"
      rescue ActionView::MissingTemplate
        render "publinator/home/index"
      end
    end

    def page
      @publication = Publinator::Publication.get_by_slug(params[:slug])
      if @publication.nil?
        raise ActionController::RoutingError.new('Not Found')
        return
      else
        # todo: render a template for the Publishable, if one exists
      end
    end
  end
end
