module Publinator
  class Publishable < ActiveRecord::Base
    has_one    :publication, :as => :publishable, :class_name => "Publinator::Publication"
    belongs_to :site,                             :class_name => "Publinator::Site"
    belongs_to :section
    accepts_nested_attributes_for   :publication
    attr_accessible                 :site, :publication, :section
    validates_presence_of           :publication
    validates_associated            :publication
    before_save                     :set_publishable_type

    def editable_fields
      attribute_names - ["id", "created_at", "updated_at"]
    end
    
    def set_publishable_type
      self.publication.publishable_type = self.class.to_s
    end
  end
end
