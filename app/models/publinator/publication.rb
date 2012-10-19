module Publinator
  class Publication < ActiveRecord::Base
    # has_paper_trail
    attr_accessible :custom_slug, :parent_id, :publication_state_id,
      :publishable_id, :publishable_type, :slug, :publish_at,
      :unpublish_at, :archive_at, :section, :default, :publishable, :site
    belongs_to :publishable, :polymorphic => true
    belongs_to :section, :class_name => "Publinator::Section"
    belongs_to :site

    validates_uniqueness_of :custom_slug, :scope => [:site_id, :section_id, :publishable_type], :allow_blank => true
    validates_uniqueness_of :slug, :scope => [:site_id, :section_id, :publishable_type]
    validates_presence_of   :site

    before_validation :generate_slug
    before_save       :generate_slug

    scope :published, where(:publication_state_id => 1)
    scope :for_site, lambda { |site_id| where("site_id = ?", site_id) }

    def content
      publishable_type.constantize.find(publishable_id)
    end

    def generate_slug
      logger.info "generating slug"
      if self.slug.blank? || slug =~ /temporary_slug\d?/
        if default
          self.slug = 'index'
        elsif custom_slug.present?
          self.slug = custom_slug
        elsif publishable.present? && publishable.title.present?
          self.slug = self.publishable.title.strip.downcase.gsub(/[^a-zA-Z0-9\-\_]/, '_')
        else
          self.slug = "temporary_slug_#{rand(100000)}"
        end
      end
      logger.info "slug is #{ slug }"
    end

    def self.get_by_slug(slug)
      self.published.where(:slug => slug)
    end
  end
end
