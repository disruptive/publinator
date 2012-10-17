# TODO Validate new sections - can't conflict with publishable_types
module Publinator
  class Section < ActiveRecord::Base
    attr_accessible :layout, :name, :parent_id, :site_id
    belongs_to :site
    has_many :publications
    before_create :generate_slug

    def self.matches?(request)
      pt = self.find(:first, :conditions => ["slug = ?", request.path_parameters[:section]])
      return pt.present?
    end
    
    # current_site.id, params[:section]
    def self.get_by_site_id_and_slug(site_id, section_name)
      Section.find(:first, :conditions => ["site_id = ? and name = ?", site_id, section_name])
    end

    private
    
      def generate_slug
        self.slug = name.downcase.gsub(" ", "_")
      end
  end
end
