require "publinator/engine"

module Publinator
  module ActsAsPublishable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_publishable(options = {})
        has_one   :publication,
            :as           =>  :publishable,
            :class_name   =>  "Publinator::Publication",
            :foreign_key  =>  :publishable_id,
            :dependent    =>  :destroy

        accepts_nested_attributes_for   :publication
        validates_presence_of           :publication
        validates_associated            :publication

        has_many  :asset_items,
            :as           =>  :assetable,
            :class_name   =>  "Publinator::AssetItem",
            :foreign_key  =>  :assetable_id


        accepts_nested_attributes_for   :asset_items, :reject_if => :all_blank

        before_validation               :verify_publication

        attr_accessible                 :site, :publication, :section, :default,
                                        :position, :asset_items_attributes,
                                        :custom_slug, :site_id, :section_id,
                                        :publication_attributes

        attr_accessor                   :default

        scope :non_index, joins(:publication).where("publication.slug != 'index'")
        delegate :site, :position, :section, :slug, :to => :publication
      end
    end

    def is_publishable?
      true
    end

    def asset_types
      []
    end

    def asset_files(asset_type_text = nil)
      return asset_items if !asset_type_text
      asset_items.where(:asset_type => asset_type_text)
    end

    def my_slug
      slug
    end

    def related_items(scope)
      []
    end

    def editable_fields
      attribute_names - ["id", "created_at", "updated_at"]
    end

    def path
      raise "publication not found" if !self.publication
      if self.publication.section
        "#{self.publication.section.path}/#{self.publication.slug}"
      else
        "/#{self.class.to_s.tableize}/#{self.publication.slug}"
      end
    end

    def url
      site.url(path)
    end

    def menu_collection
      nil
    end

    def verify_publication
      if publication.nil?
        self.publication = Publinator::Publication.new(:publishable => self)
      end
      self.publication.site     = site unless publication.site.present?
      self.publication.section  = section unless !section
      self.publication.default  = default
    end
  end
end

ActiveRecord::Base.send :include, Publinator::ActsAsPublishable

