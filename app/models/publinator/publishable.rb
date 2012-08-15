module Publinator
  class Publishable < ActiveRecord::Base
    # has_paper_trail
    has_one :publication, :as => :publishable
    accepts_nested_attributes_for :publication
    
    # def self.publishable_classes
    #       PublishableType.all.each do |pt|
    #         class_name = pt.name.capitalize!
    #         
    #       end
    #     end
  end
end
