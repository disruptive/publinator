require_dependency "publinator/application_controller"

module Publinator
  class SectionController < ApplicationController
    before_filter :get_section

    def index
      @publication = Publinator::Publication.find_by_section_id_and_slug(@section.id, 'index')
      @publishable = @publication.publishable
      if @publication.publishable_type
        @publishable_type = Publinator::PublishableType.find_by_name(@publication.publishable_type.classify)
      end
      begin
        render "#{params[:section]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    end

    def show
      @publication = Publinator::Publication.find(:first, :conditions => ["section_id = ? and slug = ?", @section.id, params[:id]])
      @publishable = @publication.publishable
      if @publication.publishable_type
        @publishable_type = Publinator::PublishableType.find_by_name(@publication.publishable_type.classify)
      end
      begin
        if @publishable_type
          render "#{@publishable_type.tableize}/show"
        else
          render "#{params[:section]}/#{@publication.slug}"
        end
      rescue ActionView::MissingTemplate
        render "publinator/publishable/show"
      end
    end

    private

      def get_section
        @section = Publinator::Section.find(:first, :conditions => ["site_id = ? AND section_slug = ?", current_site.id, params[:section]])
      end
  end
end
