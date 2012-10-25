# TODO Validate: section_slug can't conflict with publishable_types
# TODO Validate: section_slug is url friendly
# TODO Validate: children have to have the same site_id as parents
module Publinator
  class Section < ActiveRecord::Base
    attr_accessible :layout, :name, :parent_id, :site, :section_slug

    has_many :publications, :class_name => "Publinator::Publication", :order => "position"
    before_create :generate_section_slug
    alias_attribute :title, :name
    alias_attribute :slug, :section_slug

    def self.matches?(request)
      pt = self.find(:first, :conditions => ["section_slug = ?", request.path_parameters[:section]])
      return pt.present?
    end

    # current_site.id, params[:section]
    def self.get_by_site_id_and_slug(site_id, section_name)
      Section.find(:first, :conditions => ["site_id = ? and name = ?", site_id, section_name])
    end

    def index_item
      Publinator::Publication.find_by_section_id_and_slug(id, 'index')
    end

    def path
      "/#{section_slug}"
    end

    def menu_collection
      publications + child_sections
    end

    def publishable
      self
    end

    def publishables
      publications
    end

    def generate_section_slug
      self.section_slug = name.strip.downcase.gsub(/[^a-zA-Z0-9\-\_]/, '_') if section_slug.blank?
    end

    def child_sections
      Section.where(:parent_id => id)
    end

    def parent_section
      Section.where(:id => parent_id).first if parent_id
    end
  end
end
