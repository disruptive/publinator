module Publinator
  class Publication < ActiveRecord::Base
    # has_paper_trail
    attr_accessible :custom_slug, :parent_id, :publication_state_id,
      :publishable_id, :publishable_type, :slug, :publish_at,
      :unpublish_at, :archive_at, :section, :default, :publishable, :site
    belongs_to :publishable, :polymorphic => true
    belongs_to :section
    belongs_to :site

    validates_uniqueness_of :custom_slug, :scope => [:site_id, :section_id, :publishable_type], :allow_blank => true
    validates_uniqueness_of :slug, :scope => [:site_id, :section_id, :publishable_type]
    validates_presence_of   :site_id
    
    before_validation :generate_slug

    scope :published, where(:publication_state_id => 1)
    scope :for_site, lambda { |site_id| where("site_id = ?", site_id) }

    def generate_slug
      if slug.blank? || slug =~ /temporary_slug\d?/
        if custom_slug.present?
          self.slug = custom_slug
        elsif publishable.present? && publishable.title.present?
          self.slug = publishable.title.strip.downcase.gsub(" ", "-")
        elsif publishable.present? && publication.section_id.present?
          self.slug = 'index'
        else
          self.slug = "temporary_slug_#{rand(100000)}"
        end
      end
    end

    def self.get_by_slug(slug)
      self.published.where(:slug => slug)
    end
  end
end
