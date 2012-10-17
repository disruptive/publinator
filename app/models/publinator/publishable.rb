module Publinator
  class Publishable < ActiveRecord::Base
    has_one :publication, :as => :publishable, :class_name => "Publinator::Publication"

    accepts_nested_attributes_for :publication
    attr_accessible :site_id, :section_id, :custom_slug
    attr_accessor :site_id, :section_id, :custom_slug
    
    validates_presence_of :publication
    validates_associated :publication
    
    before_validation :prepare_publication

    def editable_fields
      attribute_names - ["id", "created_at", "updated_at"]
    end
    
    def section_id=(section_int)
      @section = Section.find(section_int)
      add_publication if publication.nil?
      self.publication.section_id = @section.id if @section
      self.publication.site_id = @section.site.id if @section.site
    end
    
    def section_id
      publication.section_id if publication
    end
    
    def site_id=(site_int)
      @site = Site.find(site_int)
      add_publication if publication.nil?
      self.publication.site_id = @site.id if @site
    end
    
    def site_id
      publication.site_id if publication
    end
    
    def prepare_publication
      logger.info "preparing publication"
      my_name = self.class.to_s
      logger.info "My name is #{my_name}"
      add_publication if publication.nil?
      publication.generate_slug
      publication.publishable_type = my_name
    end
    
    def custom_slug=(slug_string)
      add_publication if publication.nil?
      publication.custom_slug = slug_string
    end
    
    def custom_slug
      publication.custom_slug unless publication.nil?
    end
    
    private
    
      def add_publication
        logger.info "creating publication"
        self.publication = Publinator::Publication.new(:publishable => self)
      end
  end
end
