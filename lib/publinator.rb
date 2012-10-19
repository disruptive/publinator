require "publinator/engine"

module Publinator
  module ActsAsPublishable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_publishable(options = {})
        has_one                     :publication,
            :as           =>            :publishable,
            :class_name   =>            "Publinator::Publication",
            :foreign_key  =>            :publishable_id

        accepts_nested_attributes_for   :publication
        validates_presence_of           :publication
        validates_associated            :publication

        before_validation               :verify_publication
        belongs_to                      :site,    :class_name => "Publinator::Site"
        belongs_to                      :section, :class_name => "Publinator::Section"

        attr_accessible                 :site, :publication, :section, :default
        attr_accessor                   :default

        scope :non_index, joins(:publication).where("publication.slug != 'index'")
      end
    end

    def editable_fields
      attribute_names - ["id", "created_at", "updated_at"]
    end

    def path
      raise "publication not found" if !self.publication
      if self.publication.section
        "/#{self.publication.section.section_slug}/#{self.publication.slug}"
      else
        "/#{self.class.to_s.pluralize}/#{self.publication.slug}"
      end
    end

    def verify_publication
      logger.info "verifying publication"
      if publication.nil?
        self.publication = Publinator::Publication.new(:publishable => self)
      end
      self.publication.site     = site
      self.publication.section  = section unless !section
      self.publication.default  = default
    end
  end
end

ActiveRecord::Base.send :include, Publinator::ActsAsPublishable

