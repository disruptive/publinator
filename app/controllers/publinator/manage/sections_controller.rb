require_dependency "publinator/application_controller"

module Publinator
  class Manage::SectionsController < Publinator::ManageController

    before_filter :get_section, :except => [:index, :new]

    def index
      @sections = current_site.sections
    end

    def show
      render :edit
    end

    def edit
    end

    def new
      @section = Section.new(:site => current_site)
    end

    def create
      @section = Section.new(params[:section])
      @section.site_id = current_site.id
      if @section.save
        redirect_to manage_sections_path, :notice => "Section created."
      else
        render :new, :notice => "Section could not be created."
      end
    end

    def update
      @section.update_attributes(params[:section])
      @section.site_id = current_site.id
      if @section.save
        redirect_to manage_sections_path, :notice => "Section updated."
      else
        render :edit, :notice => "Section could not be updated."
      end
    end

    def sort
      @section.publications.each do |publication|
        publication.position = params['publication'].index(publication.id.to_s) + 1
        publication.save
      end
      render :nothing => true
    end


    private

      def get_section
        @section = current_site.sections.find_by_id(params[:id])
      end
  end
end

