require "publinator/engine"

module Publinator
  module ActsAsPublishable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_publishable(options = {})
        has_one   :publication,
            :as           =>  :publishable,
            :class_name   =>  "Publinator::Publication",
            :foreign_key  =>  :publishable_id

        accepts_nested_attributes_for   :publication
        validates_presence_of           :publication
        validates_associated            :publication

        has_many  :asset_items,
            :as           =>  :assetable,
            :class_name   =>  "Publinator::AssetItem",
            :foreign_key  =>  :assetable_id


        accepts_nested_attributes_for   :asset_items, :reject_if => :all_blank

        before_validation               :verify_publication
        belongs_to                      :site,    :class_name => "Publinator::Site"
        belongs_to                      :section, :class_name => "Publinator::Section"

        attr_accessible                 :site, :publication, :section, :default,
                                        :position, :asset_items_attributes,
                                        :custom_slug,
                                        :publication_attributes

        attr_accessor                   :default

        scope :non_index, joins(:publication).where("publication.slug != 'index'")
      end
    end

    def asset_types
      []
    end

    def asset_file(asset_type_text)
      publishable_asset = get_asset_by_type(asset_type_text)
      publishable_asset.asset_file if publishable_asset
    end

    def my_slug
      publication.slug
    end

    def asset_files
      asset_types.collect{ |atype| asset_file(atype) }
    end

    def editable_fields
      attribute_names - ["id", "created_at", "updated_at", "section_id", "site_id"]
    end

    def path
      raise "publication not found" if !self.publication
      if self.publication.section
        "/#{self.publication.section.section_slug}/#{self.publication.slug}"
      else
        "/#{self.class.to_s.pluralize}/#{self.publication.slug}"
      end
    end

    def menu_collection
      nil
    end

    def verify_publication
      logger.info "verifying publication"
      if publication.nil?
        self.publication = Publinator::Publication.new(:publishable => self)
      end
      self.publication.site     = site unless publication.site.present?
      self.publication.section  = section unless !section
      self.publication.default  = default
    end

    private

      def get_asset_by_type(asset_type_text)
        all_of_asset_type = asset_items.where(:asset_type => asset_type_text)
        all_of_asset_type.first if all_of_asset_type && all_of_asset_type.length
      end

  end
end

ActiveRecord::Base.send :include, Publinator::ActsAsPublishable

