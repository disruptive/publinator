module Publinator
  class PublishableType < ActiveRecord::Base
    attr_accessible :name, :sluggable, :layout, :use_layout

    def self.matches?(request)
      pt = self.find_by_name(request.path_parameters[:publishable_type].singularize.capitalize)
      return pt.present?
    end
  end
end
