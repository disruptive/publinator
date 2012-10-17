require_dependency "publinator/application_controller"

module Publinator
  class SectionController < ApplicationController
    before_filter :get_section
    
    def index
      @publication = Publinator::Publication.find_by_section_id_and_slug(@section.id, 'index')
      @publishable = @publication.publishable
      begin
        render "#{params[:section]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    rescue Exception => e
      logger.info e.to_yaml
      # redirect_to root_url, :notice => "Page not found." if @publication.nil?
    end

    def show
      @publication = Publinator::Publication.find(:first, :conditions => ["section_id = ? and slug = ?", @section.id, params[:id]])
      @publishable = @publication.publishable
      begin
        render "#{params[:section]}/show"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    end
    
    private
    
      def get_section
        @section = Publinator::Section.find(:first, :conditions => ["site_id = ? AND name = ?", current_site.id, params[:section]])
      end
  end
end