module Publinator
  class Publishable < ActiveRecord::Base

    # has_paper_trail
    has_one :publication, :class_name => 'Publinator::Publication'
    accepts_nested_attributes_for :publication
    #validates_associated :publication

    def editable_fields
      attribute_names - ["id", "created_at", "updated_at"]
    end

    # def self.publishable_classes
    #       PublishableType.all.each do |pt|
    #         class_name = pt.name.capitalize!
    #
    #       end
    #     end
  end
end
