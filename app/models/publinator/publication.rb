module Publinator
  class Publication < ActiveRecord::Base
    # has_paper_trail
    attr_accessible :custom_slug, :parent_id, :publication_state_id,
      :publishable_id, :publishable_type, :slug, :publish_at, :hide_in_submenu,
      :unpublish_at, :archive_at, :section, :default, :publishable, :site,
      :section_id, :collection_publishable_type_id, :collection_scope
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

    delegate :title, :path, :menu_collection, :to => :publishable

    def collection
      return unless collection_publishable_type_id
      pt = Publinator::PublishableType.find(collection_publishable_type_id)
      return if !pt
      pt.name.constantize.send(collection_scope.to_sym)
    end

    def content
      publishable_type.constantize.find(publishable_id)
    end

    def generate_slug
      if self.slug.blank? || slug =~ /temporary_slug\d?/
        if default
          self.slug = 'index'
        elsif custom_slug.present?
          self.slug = custom_slug
        elsif publishable.present? && publishable.title.present?
          self.slug = self.publishable.title.strip.downcase.gsub(/[^a-zA-Z0-9\-\_]/, '_')
          self.slug = self.slug.gsub("___", "_")
          self.slug = self.slug.gsub("__", "_")
          if slug.end_with?("_")
            self.slug = self.slug.chop
          end
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
