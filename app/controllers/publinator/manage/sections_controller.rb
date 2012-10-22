require_dependency "publinator/application_controller"

module Publinator
  class Manage::SectionsController < Publinator::ManageController

    before_filter :get_section, :except => [:index, :new]

    def index
      @sections = current_site.sections
    end

    def show
    end

    def edit
    end

    def new
      @section = Section.new(:site_id => current_site.id)
    end

    private

      def get_section
        @section = current_site.sections.find_by_id(params[:id])
      end
  end
end

